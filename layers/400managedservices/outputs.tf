###############################################################################
# Elasticsearch Output
###############################################################################
output "domain_arn" {
  value       = module.elasticsearch.domain_arn
  description = "ARN of the Elasticsearch domain"
}

output "domain_id" {
  value       = module.elasticsearch.domain_id
  description = "Unique identifier for the Elasticsearch domain"
}

output "domain_name" {
  value       = module.elasticsearch.domain_name
  description = "Name of the Elasticsearch domain"
}

output "domain_endpoint" {
  value       = module.elasticsearch.domain_endpoint
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
}

output "kibana_endpoint" {
  value       = module.elasticsearch.kibana_endpoint
  description = "Domain-specific endpoint for Kibana without https scheme"
}

###############################################################################
# DocumentDB Output
###############################################################################
output "arn" {
  value = module.documentdb.arn
}

output "cluster_members" {
  value = module.documentdb.cluster_members
}

output "cluster_resource_id" {
  value = module.documentdb.cluster_resource_id
}

output "endpoint" {
  value = module.documentdb.endpoint
}

output "hosted_zone_id" {
  value = module.documentdb.hosted_zone_id
}

output "id" {
  value = module.documentdb.id
}

output "reader_endpoint" {
  value = module.documentdb.reader_endpoint
}
