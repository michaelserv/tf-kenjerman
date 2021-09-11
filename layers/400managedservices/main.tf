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
    key     = "terraform.300managedservices.tfstate"
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
    bucket  = "130541009828-build-state-bucket-eks" ### UPDATE THE XXXXX WITH YOUR ACCOUNT ID
    key     = "terraform.000base.tfstate"
    region  = "ap-southeast-2"                        ### UPDATE THE XXXXX WITH YOUR REGION
    encrypt = "true"
  }
}

### Get the VPC Details from Compute layer
### Please update backend bucket name and region (lines 50 and 52)
data "terraform_remote_state" "_compute" {
  backend = "s3"

  config = {
    bucket  = "130541009828-build-state-bucket-eks" ### UPDATE THE XXXXX WITH YOUR ACCOUNT ID
    key     = "terraform.200compute.tfstate"
    region  = "ap-southeast-2"                        ### UPDATE THE XXXXX WITH YOUR REGION
    encrypt = "true"
  }
}

locals {
  vpc_id          = data.terraform_remote_state._vpc.outputs.vpc_id
  private_subnets = data.terraform_remote_state._vpc.outputs.private_subnets
  public_subnets  = data.terraform_remote_state._vpc.outputs.public_subnets
  vpc_cidr_block  = data.terraform_remote_state._vpc.outputs.vpc_cidr_block
  bastion_sg_id   = data.terraform_remote_state._compute.outputs.bastion_sg_id
  eks_sg_id       = data.terraform_remote_state._compute.outputs.eks_sg_id
  tags = {
    Environment = var.environment
  }
}

###############################################################################
# Security Groups - Elasticsearch
###############################################################################
resource "aws_security_group" "elasticsearch_security_group" {
  name_prefix = "elasticsearch-sg-"
  description = "Allow Elasticsearch access from EKS and Bastion"
  vpc_id      = local.vpc_id

  tags = merge(
    local.tags,
    { Name = "elasticsearch-sg" }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "elasticsearch_sg_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.elasticsearch_security_group.id
}

resource "aws_security_group_rule" "elasticsearch_sg_ingress_all_eks" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = local.eks_sg_id
  security_group_id        = aws_security_group.elasticsearch_security_group.id
  description              = "Allow EKS clusters to access Elasticsearch"
}

resource "aws_security_group_rule" "elasticsearch_sg_ingress_all_bastion" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = local.bastion_sg_id
  security_group_id        = aws_security_group.elasticsearch_security_group.id
  description              = "Allow Bastion to access Elasticsearch"
}

###############################################################################
# Elasticsearch Module
###############################################################################
module "elasticsearch" {
  source = "../../modules/elasticsearch"

  es_name                  = var.es_name
  existing_security_groups = [aws_security_group.elasticsearch_security_group.id]
  subnet_ids               = local.private_subnets
  zone_awareness_enabled   = var.zone_awareness_enabled
  elasticsearch_version    = var.elasticsearch_version
  instance_type            = var.elasticsearch_instance_type
  instance_count           = var.instance_count
  ebs_volume_size          = var.ebs_volume_size
  iam_actions              = var.iam_actions
  encrypt_at_rest_enabled  = var.encrypt_at_rest_enabled

  advanced_options = var.advanced_options
}

###############################################################################
# Security Groups - DocumentDB
###############################################################################
resource "aws_security_group" "documentdb_security_group" {
  name_prefix = "documentdb-sg-"
  description = "Allow DocumentDB access from EKS and Bastion"
  vpc_id      = local.vpc_id

  tags = merge(
    local.tags,
    { Name = "documentdb-sg" }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "documentdb_sg_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.documentdb_security_group.id
}

resource "aws_security_group_rule" "documentdb_sg_ingress_all_eks" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = local.eks_sg_id
  security_group_id        = aws_security_group.documentdb_security_group.id
  description              = "Allow EKS clusters to access DocumentDB"
}

resource "aws_security_group_rule" "documentdb_sg_ingress_all_bastion" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = local.bastion_sg_id
  security_group_id        = aws_security_group.documentdb_security_group.id
  description              = "Allow Bastion to access DocumentDB"
}

###############################################################################
# DocumentDB Module
###############################################################################
module "documentdb" {
  source = "../../modules/documentdb"

  apply_immediately       = var.apply_immediately
  backup_retention_period = var.backup_retention_period
  cluster_instance_class  = var.cluster_instance_class
  cluster_instance_count  = var.cluster_instance_count
  cluster_security_group  = [aws_security_group.documentdb_security_group.id]
  group_subnets           = local.private_subnets
  master_password         = var.master_password
  master_username         = var.master_username
  name                    = var.name
  skip_final_snapshot     = var.skip_final_snapshot
  storage_encrypted       = var.storage_encrypted
}

###############################################################################
# Security Groups - MSK
###############################################################################
resource "aws_security_group" "msk_security_group" {
  name_prefix = "msk-sg-"
  description = "Allow MSK access from EKS and Bastion"
  vpc_id      = local.vpc_id

  tags = merge(
    local.tags,
    { Name = "msk-sg" }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "msk_sg_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.msk_security_group.id
}

resource "aws_security_group_rule" "msk_sg_ingress_all_eks" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = local.eks_sg_id
  security_group_id        = aws_security_group.msk_security_group.id
  description              = "Allow EKS clusters to access MSK"
}

resource "aws_security_group_rule" "msk_sg_ingress_all_bastion" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = local.bastion_sg_id
  security_group_id        = aws_security_group.msk_security_group.id
  description              = "Allow Bastion to access MSK"
}

###############################################################################
# MSK Module
###############################################################################
module "msk" {
  source  = "../../modules/msk"

  cluster_name    = "kafka"
  instance_type   = "kafka.m5.large"
  number_of_nodes = 2
  client_subnets  = local.private_subnets
  kafka_version   = "2.6.2"
  encryption_in_transit_client_broker = "TLS"
  security_groups = [aws_security_group.msk_security_group.id]

  server_properties = {
    "auto.create.topics.enable"  = "true"
    "default.replication.factor" = "2"
  }

  tags = local.tags
}

###############################################################################
# Security Groups - RDS
###############################################################################
resource "aws_security_group" "rds_security_group" {
  name_prefix = "rds-sg-"
  description = "RDS Security Group"
  vpc_id      = local.vpc_id

  tags = merge(
    local.tags,
    { Name = "rds-sg" }
  )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "rds_sg_egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds_security_group.id
}

resource "aws_security_group_rule" "rds_sg_ingress_all_eks" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = local.eks_sg_id
  security_group_id        = aws_security_group.rds_security_group.id
  description              = "Allow EKS clusters to access RDS"
}

resource "aws_security_group_rule" "rds_sg_ingress_all_bastion" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  source_security_group_id = local.bastion_sg_id
  security_group_id        = aws_security_group.rds_security_group.id
  description              = "Allow Bastion to access RDS"
}

###############################################################################
# Modules - RDS
###############################################################################
module "rds" {
  source = "../../modules/rds"

  private_subnets = local.private_subnets
  rds_sg_id       = aws_security_group.rds_security_group.id

  db_identifier           = var.db_identifier
  db_name                 = var.db_name
  db_username             = var.db_username
  db_password             = var.db_password
  db_instance_class       = var.db_instance_class
  db_engine               = var.db_engine
  db_engine_version       = var.db_engine_version
  db_allocated_storage    = var.db_allocated_storage
  db_multi_az             = var.db_multi_az
  backup_retention_period = var.rds_backup_retention_period
  storage_encrypted       = var.rds_storage_encrypted
  skip_final_snapshot     = var.rds_skip_final_snapshot
  tags                    = local.tags

}

###############################################################################
# Modules - S3
###############################################################################
module "s3_bucket" {
  source = "../../modules/s3_bucket"

  bucket_name          = var.bucket_name
  acl                  = var.acl
  tags                 = local.tags
  force_destroy_bucket = var.force_destroy_bucket

  versioning = {
    enabled = var.versioning_enabled
  }
}
