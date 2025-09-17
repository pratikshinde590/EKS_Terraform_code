# region       = "us-east-1"
# cluster_name = "inventurs-cluster"
# vpc_cidr     = "10.0.0.0/16"

# public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
# private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

# ssh_key_name = "inventure-ec2-keypair"

# cluster_version = "1.27"

# eks_managed_node_groups = {
#   base_on_demand = {
#     min_size       = 2
#     max_size       = 3
#     desired_size   = 2
#     instance_types = ["m6a.xlarge"]
#     capacity_type  = "ON_DEMAND"
#     labels         = { node_role = "base" }
#   }
#   # burst_spot = {
#   #   min_size       = 0
#   #   max_size       = 2
#   #   desired_size   = 1
#   #   instance_types = ["m6i.large"]
#   #   capacity_type  = "SPOT"
#   #   labels         = { lifecycle = "spot" }
#   # }
# }

# tags = {
#   Environment = "prod"
#   Terraform   = "true"
# }

#===================================================================================

region       = "ap-south-1"
cluster_name = "inventurs-cluster"
vpc_cidr     = "10.0.0.0/16"

public_subnets  = []
private_subnets = []

ssh_key_name    = "inventure-ec2-keypair"
cluster_version = "1.27"

eks_managed_node_groups = {
  base_on_demand = {
    min_size       = 2
    max_size       = 5
    desired_size   = 4
    instance_types = ["t3a.medium"] # safer default for EKS bootstrap
    capacity_type  = "ON_DEMAND"
    labels         = { node_role = "base" }
  }
}

tags = {
  Environment = "prod"
  Terraform   = "true"
}

