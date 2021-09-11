###############################################################################
# Environment
###############################################################################
aws_account_id = "130541009828" ### PLEASE UPDATE THE AWS ACCOUNT NUMBER
environment    = "Development"   ### PLEASE UPDATE YOUR ENVIRONMENT IF NEEDED
region         = "ap-southeast-2" ### PLEASE UPDATE THE AWS REGION

###############################################################################
# VPC
###############################################################################
vpc_name             = "EKS VPC"
vpc_cidr             = "10.0.0.0/16"
private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets       = ["10.0.4.0/24", "10.0.5.0/24"]
enable_nat_gateway   = true
single_nat_gateway   = true
enable_dns_hostnames = true

###############################################################################
# EKS
###############################################################################
eks_cluster_name = "eks-cluster"
