###############################################################################
# Terraform main config
###############################################################################
terraform {
  required_version = ">= 1.0.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.57.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.0.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.0.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.0.0"
    }

    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.1"
    }
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
  cluster_name    = data.terraform_remote_state._vpc.outputs.eks_cluster_name
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
# Bastion IAM
###############################################################################
resource "aws_iam_role" "bastion_role" {
  name = "bastion_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = local.tags
}

resource "aws_iam_policy_attachment" "AmazonEKSWorkerNodePolicy-attach" {
  name       = "bastion-attachment"
  roles      = [aws_iam_role.bastion_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion_profile"
  role = aws_iam_role.bastion_role.name
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
  iam_instance_profile   = aws_iam_instance_profile.bastion_profile.name

  tags = merge(
    local.tags,
    { Name = "Bastion" }
  )
}

###############################################################################
# Security Groups - EKS Worker Nodes
###############################################################################
resource "aws_security_group" "eks_bastion_security_group" {
  name_prefix = "worker-nodes-sg"
  vpc_id      = local.vpc_id

  tags = merge(
    local.tags,
    { Name = "access-to-worker-nodes" }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "eks_bastion_sg_ingress_all" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.bastion_security_group.id
  security_group_id        = aws_security_group.eks_bastion_security_group.id
  description              = "Allow Bastion Access to EKS worker nodes"
}

###############################################################################
# Modules - EKS
###############################################################################
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "17.1.0"

  cluster_name    = local.cluster_name
  cluster_version = var.eks_cluster_version
  subnets         = local.private_subnets

  map_roles = [{
    rolearn  = "arn:aws:iam::130541009828:role/bastion_role"
    username = "system:node:{{EC2PrivateDNSName}}"
    groups   = ["system:bootstrappers", "system:nodes"]
  }]

  tags = {
    Environment = var.environment
  }

  vpc_id = local.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = var.worker_nodes_name
      instance_type                 = var.worker_nodes_instance_type
      asg_desired_capacity          = var.worker_nodes_asg_desired_capacity
      additional_security_group_ids = [aws_security_group.eks_bastion_security_group.id]
    },
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
