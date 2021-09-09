###############################################################################
# Terraform main config
###############################################################################
terraform {
  required_version = ">= 1.0.4"
  required_providers {
    aws = ">= 3.57.0"
  }
  backend "s3" {
    bucket  = "XXXXXXXXXXXXXX-build-state-bucket-eks" ### UPDATE THE XXXXX WITH YOUR ACCOUNT ID
    key     = "terraform.200compute.tfstate"
    region  = "XXXXXXXXXXXXXX"                        ### UPDATE THE XXXXX WITH YOUR REGION
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

###############################################################################
# Data Sources
###############################################################################
data "aws_availability_zones" "available" {
}

### Get the VPC Details from VPC layer
### Please update backend bucket name and region (lines 37 and 39)
data "terraform_remote_state" "_vpc" {
  backend = "s3"

  config = {
    bucket  = "XXXXXXXXXXXXXX-build-state-bucket-eks" ### UPDATE THE XXXXX WITH YOUR ACCOUNT ID
    key     = "terraform.000base.tfstate"
    region  = "XXXXXXXXXXXXXX"                        ### UPDATE THE XXXXX WITH YOUR REGION
    encrypt = "true"
  }
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

locals {
  vpc_id          = data.terraform_remote_state._vpc.outputs.vpc_id
  private_subnets = data.terraform_remote_state._vpc.outputs.private_subnets
  public_subnets  = data.terraform_remote_state._vpc.outputs.public_subnets
  vpc_cidr_block  = data.terraform_remote_state._vpc.outputs.vpc_cidr_block
  tags = {
    Environment = var.environment
  }
}

###############################################################################
# Security Groups - Bastion
###############################################################################
resource "aws_security_group" "bastion_security_group" {
  name_prefix = "bastion-sg-"
  description = "Bastion Security Group"
  vpc_id      = local.vpc_id

  tags = merge(
    local.tags,
    { Name = "bastion-sg" }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "bastion_sg_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_security_group.id
}

resource "aws_security_group_rule" "bastion_sg_ingress_all" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_security_group.id
  description       = "Allow Public access to Bastion"
}

###############################################################################
# Bastion
###############################################################################
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon-linux-2.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = local.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.bastion_security_group.id]
  user_data_base64       = base64encode(var.user_data)

  tags = merge(
    local.tags,
    { Name = "Bastion" }
  )
}
