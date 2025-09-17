# variable "region" {
#   type = string
# }

# variable "cluster_name" {
#   type = string
# }

# variable "vpc_cidr" {
#   type = string
# }

# variable "public_subnets" {
#   type = list(string)
# }

# variable "private_subnets" {
#   type = list(string)
# }

# variable "ssh_key_name" {
#   type = string
# }

# variable "cluster_version" {
#   type    = string
#   default = "1.27" # Can override in tfvars if needed
# }

# variable "eks_managed_node_groups" {
#   description = "Map of EKS managed node group definitions"
#   type = map(object({
#     min_size       = number
#     max_size       = number
#     desired_size   = number
#     instance_types = list(string)
#     capacity_type  = string
#     labels         = map(string)
#   }))
# }

# variable "tags" {
#   description = "Tags for all AWS resources"
#   type        = map(string)
# }

#==========================================================================================

variable "region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type    = string
  default = "1.27"
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "ssh_key_name" {
  type = string
}

variable "eks_managed_node_groups" {
  type = any
}

variable "tags" {
  type = map(string)
}

