###############################################################################
# Terraform main config
###############################################################################
terraform {
  required_version = ">= 1.0.4"
  required_providers {
    aws = ">= 3.57.0"
  }
  backend "s3" {
    bucket  = "130541009828-build-state-bucket-eks" ### UPDATE THE XXXXX WITH YOUR ACCOUNT ID
    key     = "terraform.000base.tfstate"
    region  = "ap-southeast-2"                        ### UPDATE THE XXXXX WITH YOUR REGION
    encrypt = "true"
  }
}

###############################################################################
# Providers
###############################################################################
provider "aws" {
  region              = var.region
  allowed_account_ids = [var.aws_account_id]
}

data "aws_availability_zones" "available" {
}

locals {
  cluster_name = var.eks_cluster_name
  tags = {
    Environment = var.environment
  }
}

###############################################################################
# Modules - VPC
###############################################################################
module "vpc" {
  source = "../../modules/vpc_kube"

  name                 = var.vpc_name
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = var.private_subnets
  public_subnets       = var.public_subnets
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
