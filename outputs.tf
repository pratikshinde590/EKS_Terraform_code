output "cluster_name" {
  value = module.eks.cluster_id
}

output "kubeconfig_command" {
  value = module.eks.cluster_id != null ? "aws eks update-kubeconfig --name ${module.eks.cluster_id} --region ${var.region}" : ""
}

output "cluster_endpoint" {
  value = data.aws_eks_cluster.cluster.endpoint
}
