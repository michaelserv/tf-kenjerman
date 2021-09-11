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
# Variables - Bastion
###############################################################################
variable "instance_type" {
  description = "The instance type to use for the instance."
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key name of the Key Pair to use for the instance."
}

variable "user_data" {
  description = "User data to provide when launching the instance."
  default     = null
}

###############################################################################
# Variables - EKS
###############################################################################
variable "eks_cluster_version" {
  description = "Kubernetes version to use for the EKS cluster."
  type        = string
  default     = "1.20"
}

variable "worker_nodes_name" {
  description = "Name of the EKS EC2 worker node."
  type        = string
  default     = "worker-group-1"
}

variable "worker_nodes_instance_type" {
  description = "Instance Type of the EKS EC2 worker node."
  type        = string
  default     = "t2.small"
}

variable "worker_nodes_asg_desired_capacity" {
  description = "Number of the desired capacity for the EKS EC2 worker node."
  type        = number
  default     = 2
}
