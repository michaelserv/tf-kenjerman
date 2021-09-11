###############################################################################
# Elasticsearch Output
###############################################################################
output "elasticsearch_domain_arn" {
  value       = module.elasticsearch.domain_arn
  description = "ARN of the Elasticsearch domain."
}

output "elasticsearch_domain_id" {
  value       = module.elasticsearch.domain_id
  description = "Unique identifier for the Elasticsearch domain."
}

output "elasticsearch_domain_name" {
  value       = module.elasticsearch.domain_name
  description = "Name of the Elasticsearch domain."
}

output "elasticsearch_domain_endpoint" {
  value       = module.elasticsearch.domain_endpoint
  description = "Domain-specific endpoint used to submit index, search, and data upload requests."
}

output "elasticsearch_kibana_endpoint" {
  value       = module.elasticsearch.kibana_endpoint
  description = "Domain-specific endpoint for Kibana without https scheme."
}

###############################################################################
# DocumentDB Output
###############################################################################
output "documentdb_arn" {
  value = module.documentdb.arn
  description = "Amazon Resource Name (ARN) of the DocumentDB cluster."
}

output "documentdb_cluster_members" {
  value = module.documentdb.cluster_members
  description = "List of DocDB Instances that are a part of this cluster."
}

output "documentdb_cluster_resource_id" {
  value = module.documentdb.cluster_resource_id
  description = "The DocDB Cluster Resource ID."
}

output "documentdb_endpoint" {
  value = module.documentdb.endpoint
  description = "The DNS address of the DocDB instance."
}

output "documentdb_hosted_zone_id" {
  value = module.documentdb.hosted_zone_id
  description = "The Route53 Hosted Zone ID of the endpoint."
}

output "documentdb_id" {
  value = module.documentdb.id
  description = "The DocDB Cluster Identifier."
}

output "documentdb_reader_endpoint" {
  value = module.documentdb.reader_endpoint
  description = "A read-only endpoint for the DocDB cluster, automatically load-balanced across replicas."
}

###############################################################################
# MSK Output
###############################################################################
output "msk_cluster_arn" {
  description = "Amazon Resource Name (ARN) of the MSK cluster."
  value       = module.msk.arn
}

output "msk_cluster_bootstrap_brokers" {
  description = "A comma separated list of one or more hostname:port pairs of kafka brokers suitable to boostrap connectivity to the kafka cluster. Only contains value if client_broker encryption in transit is set o PLAINTEXT or TLS_PLAINTEXT."
  value       = module.msk.bootstrap_brokers
}

output "msk_cluster_bootstrap_brokers_tls" {
  description = "A comma separated list of one or more DNS names (or IPs) and TLS port pairs kafka brokers suitable to boostrap connectivity to the kafka cluster. Only contains value if client_broker encryption in transit is set to TLS_PLAINTEXT or TLS."
  value       = module.msk.bootstrap_brokers_tls
}

output "msk_cluster_current_version" {
  description = "Current version of the MSK Cluster used for updates"
  value       = module.msk.current_version
}

output "msk_cluster_encryption_at_rest_kms_key_arn" {
  description = "The ARN of the KMS key used for encryption at rest of the broker data volumes."
  value       = module.msk.encryption_at_rest_kms_key_arn
}

output "msk_cluster_zookeeper_connect_string" {
  description = "A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster."
  value       = module.msk.zookeeper_connect_string
}

###############################################################################
# RDS Output
###############################################################################
output "rds_address" {
  description = "The hostname of the RDS instance."
  value       = module.rds.rds_address
}

###############################################################################
# S3 Bucket Output
###############################################################################
output "s3_bucket_id" {
  description = "The Id of the s3 bucket."
  value       = module.s3_bucket.bucket_id
}
