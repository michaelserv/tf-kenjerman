###############################################################################
# Environment
###############################################################################
aws_account_id = "130541009828" ### PLEASE UPDATE THE AWS ACCOUNT NUMBER
environment    = "Development"   ### PLEASE UPDATE YOUR ENVIRONMENT IF NEEDED
region         = "ap-southeast-2" ### PLEASE UPDATE THE AWS REGION

###############################################################################
# Elasticsearch
###############################################################################
es_name                     = "es-cluster"
zone_awareness_enabled      = "true"
elasticsearch_version       = "7.9"
elasticsearch_instance_type = "t2.medium.elasticsearch"
instance_count              = 2
ebs_volume_size             = 10
iam_actions                 = ["es:ESHttpGet", "es:ESHttpPut", "es:ESHttpPost"]
encrypt_at_rest_enabled     = "false"
advanced_options = {
  "rest.action.multi.allow_explicit_index" = "true"
}

###############################################################################
# DocumentDB
###############################################################################
apply_immediately       = true
backup_retention_period = 7
cluster_instance_class  = "db.r5.large"
cluster_instance_count  = 1
master_password         = "docdb_master_pass123"
master_username         = "docdb_master_username"
name                    = "docdb-cluster"
skip_final_snapshot     = true
storage_encrypted       = true

###############################################################################
# MSK
###############################################################################
cluster_name                        = "kafka"
instance_type                       = "kafka.m5.large"
number_of_nodes                     = 2
kafka_version                       = "2.6.2"
encryption_in_transit_client_broker = "TLS"
server_properties = {
  "auto.create.topics.enable"  = "true"
  "default.replication.factor" = "2"
}

###############################################################################
# RDS
###############################################################################
db_identifier           = "postgres-db"
db_name                 = "eksdb"
db_username             = "eks_admin" ### PLEASE UPDATE USERNAME
db_password             = "admin123"  ### PLEASE UPDATE TEMPORARY PASSWORD
db_instance_class       = "db.t3.small"
db_engine               = "postgres"
db_engine_version       = "12.5"
db_allocated_storage    = 50
db_multi_az             = false ### SET TRUE FOR PRODUCTION
rds_backup_retention_period = 7
rds_storage_encrypted       = true
rds_skip_final_snapshot     = true

###############################################################################
# S3 Bucket / IAM
###############################################################################
bucket_name          = "maven-eks-s3-2265" ### PLEASE UPDATE FOR THE S3 BUCKET NAME, THIS IS UNIQUE WORLD WIDE
acl                  = "private"
versioning_enabled   = true
force_destroy_bucket = true
