# Create the policy for Cluster Autoscaler
resource "aws_iam_policy" "cluster_autoscaler" {
  name        = "${var.cluster_name}-cluster-autoscaler-policy"
  description = "Policy for Kubernetes Cluster Autoscaler"

  policy = file("${path.module}/policies/cluster-autoscaler-policy.json")
}

# Service account via IRSA: create an IAM role and annotate service account with the role.
resource "aws_iam_role" "cluster_autoscaler" {
  name = "${var.cluster_name}-cluster-autoscaler-role"

  assume_role_policy = data.aws_iam_policy_document.cluster_autoscaler_assume_role.json
}

data "aws_iam_policy_document" "cluster_autoscaler_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["sts.amazonaws.com"]
    }
    actions = ["sts:AssumeRoleWithWebIdentity"]
    # The module sets up IRSA OIDC. Attach the OIDC provider as principal with condition in actual production.
  }
}

resource "aws_iam_role_policy_attachment" "attach_ca_policy" {
  role       = aws_iam_role.cluster_autoscaler.name
  policy_arn = aws_iam_policy.cluster_autoscaler.arn
}
