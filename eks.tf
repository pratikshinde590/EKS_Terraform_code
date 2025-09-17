# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = ">= 20.0"

#   name    = var.cluster_name
#   vpc_id     = module.vpc.vpc_id
#   subnet_ids = module.vpc.private_subnets

#   enable_irsa = true

#   eks_managed_node_groups = {
#     base_on_demand = {
#       min_size     = 2
#       max_size     = 3
#       desired_size = 2
#       instance_types = ["m6a.xlarge"]
#       capacity_type  = "ON_DEMAND"
#       labels = {
#         node_role = "base"
#       }
#     }

#     # burst_spot = {
#     #   min_size     = 0
#     #   max_size     = 2
#     #   desired_size = 1
#     #   instance_types = ["m6i.large"]
#     #   capacity_type  = "SPOT"
#     #   labels = {
#     #     lifecycle = "spot"
#     #   }
#     # }
#   }

#   cluster_tags = {
#     Environment = "prod"
#     Terraform   = "true"
#   }
# }

#=====================================================================================

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">= 20.0"

  name    = var.cluster_name
  vpc_id  = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # cluster_version = var.cluster_version
  enable_irsa     = true

  eks_managed_node_groups = var.eks_managed_node_groups

  cluster_tags = var.tags
}

