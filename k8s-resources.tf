# Add the spot taint to all nodes created by the burst_spot node group.
# We will use a small null_resource with local-exec to run kubectl after the cluster is ready.

resource "null_resource" "taint_spot_nodes" {
  depends_on = [module.eks, data.aws_eks_cluster.cluster, data.aws_eks_cluster_auth.cluster]

  provisioner "local-exec" {
    command = <<EOT
# wait for nodes
set -e
for i in {1..30}; do
  ready=$(kubectl get nodes -l lifecycle=spot --no-headers 2>/dev/null | wc -l || true)
  if [ "$ready" != "0" ]; then
    echo "Found spot nodes, applying taint"
    kubectl get nodes -l lifecycle=spot -o name | xargs -r -n1 kubectl taint nodes --overwrite {} lifecycle=spot:NoSchedule || true
    exit 0
  fi
  echo "waiting for spot nodes..."
  sleep 10
done
echo "timeout waiting for spot nodes"
exit 1
EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

# Create a Kubernetes service account for Cluster Autoscaler and annotate it with the IAM role ARN (IRSA)
resource "kubernetes_service_account" "cluster_autoscaler" {
  metadata {
    name      = "cluster-autoscaler"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.cluster_autoscaler.arn
    }
  }

  depends_on = [data.aws_eks_cluster.cluster, data.aws_eks_cluster_auth.cluster, aws_iam_role.cluster_autoscaler]
}

# Deploy AWS Node Termination Handler via Helm
resource "helm_release" "aws_node_termination_handler" {
  name       = "aws-node-termination-handler"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-node-termination-handler"
  namespace  = "kube-system"

  create_namespace = false

  values = [
    file("${path.module}/helm_values/aws-node-termination-handler.yaml")
  ]

  depends_on = [data.aws_eks_cluster.cluster, data.aws_eks_cluster_auth.cluster]
}

# Deploy Cluster Autoscaler via Helm
resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"

  create_namespace = false

  set = [
    {
      name  = "autoDiscovery.clusterName"
      value = module.eks.cluster_id
    },
    {
      name  = "awsRegion"
      value = var.region
    },
    {
      name  = "rbac.serviceAccount.create"
      value = "false"
    },
    {
      name  = "rbac.serviceAccount.name"
      value = kubernetes_service_account.cluster_autoscaler.metadata[0].name
    }
  ]

  depends_on = [kubernetes_service_account.cluster_autoscaler]
}
