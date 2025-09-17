# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = ">= 3.0"

#   name = "${var.cluster_name}-vpc"
#   cidr = var.vpc_cidr

#   azs             = slice(data.aws_availability_zones.available.names, 0, 3)
#   public_subnets  = length(var.public_subnets) > 0 ? var.public_subnets : ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
#   private_subnets = length(var.private_subnets) > 0 ? var.private_subnets : ["10.0.11.0/24","10.0.12.0/24","10.0.13.0/24"]

#   enable_nat_gateway = true
#   single_nat_gateway = true

#   tags = {
#     "Name" = "${var.cluster_name}-vpc"
#   }
# }

# data "aws_availability_zones" "available" {}

#=====================================================================================

data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 3.0"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets  = length(var.public_subnets) > 0 ? var.public_subnets : ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
  private_subnets = length(var.private_subnets) > 0 ? var.private_subnets : ["10.0.11.0/24","10.0.12.0/24","10.0.13.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    "Name" = "${var.cluster_name}-vpc"
  }
}

