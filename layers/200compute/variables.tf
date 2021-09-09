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
