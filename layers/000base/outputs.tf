###############################################################################
# Outputs - VPC
###############################################################################
output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC."
  value       = module.vpc.vpc_cidr_block
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "data_subnets" {
  description = "List of IDs of data subnets"
  value       = module.vpc.database_subnets
}

###############################################################################
# Outputs - EKS
###############################################################################
output "eks_cluster_name" {
  description = "Name of the EKS Cluster."
  value       = local.cluster_name
}
