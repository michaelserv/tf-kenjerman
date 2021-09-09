###############################################################################
# Variables - Environment
###############################################################################
variable "aws_account_id" {
  description = "(Required) AWS Account ID."
}

variable "region" {
  description = "(Required) Region where resources will be created."
  default     = "ap-southeast-2"
}

variable "environment" {
  description = "(Optional) The name of the environment, e.g. Production, Development, etc."
  default     = "Development"
}

###############################################################################
# Variables - VPC
###############################################################################
variable "vpc_name" {
  description = "Name to be used on all the VPC resources as identifier."
  type        = string
  default     = "VPC"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  type        = list(any)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  type        = list(any)
  default     = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your private networks."
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

###############################################################################
# Variables - EKS
###############################################################################
variable "eks_cluster_name" {
  description = "Name of the EKS Cluster."
  type        = string
  default     = "eks-staging-cluster"
}
