data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
  depends_on = [module.eks]
}
