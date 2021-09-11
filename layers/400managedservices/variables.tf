###############################################################################
# Variables - Environment
###############################################################################
variable "aws_account_id" {
  description = "AWS Account ID."
}

variable "region" {
  description = "Region where resources will be created."
  default     = "ap-southeast-2"
}

variable "environment" {
  description = "The name of the environment, e.g. Production, Development, etc."
  default     = "Development"
}

###############################################################################
# Variables - Elasticsearch
###############################################################################
variable "create_iam_service_linked_role" {
  type        = bool
  default     = true
  description = "Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info"
}

variable "iam_role_max_session_duration" {
  type        = number
  default     = 3600
  description = "The maximum session duration (in seconds) for the user role. Can have a value from 1 hour to 12 hours"
}

variable "es_name" {
  type        = string
  description = "Name of the Elasticsearch domain."
  default     = "hoot"
}

variable "iam_authorizing_role_arns" {
  type        = list(string)
  default     = []
  description = "List of IAM role ARNs to permit to assume the Elasticsearch user role"
}

variable "aws_ec2_service_name" {
  type        = list(string)
  default     = ["ec2.amazonaws.com"]
  description = "AWS EC2 Service Name"
}

variable "elasticsearch_version" {
  type        = string
  default     = "7.4"
  description = "Version of Elasticsearch to deploy (_e.g._ `7.4`, `7.1`, `6.8`, `6.7`, `6.5`, `6.4`, `6.3`, `6.2`, `6.0`, `5.6`, `5.5`, `5.3`, `5.1`, `2.3`, `1.5`"
}

variable "advanced_options" {
  type        = map(string)
  default     = {}
  description = "Key-value string pairs to specify advanced configuration options"
}

variable "advanced_security_options_enabled" {
  type        = bool
  default     = false
  description = "AWS Elasticsearch Kibana enchanced security plugin enabling (forces new resource)"
}

variable "advanced_security_options_internal_user_database_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable or not internal Kibana user database for ELK OpenDistro security plugin"
}

variable "advanced_security_options_master_user_arn" {
  type        = string
  default     = ""
  description = "ARN of IAM user who is to be mapped to be Kibana master user (applicable if advanced_security_options_internal_user_database_enabled set to false)"
}

variable "advanced_security_options_master_user_name" {
  type        = string
  default     = ""
  description = "Master user username (applicable if advanced_security_options_internal_user_database_enabled set to true)"
}

variable "advanced_security_options_master_user_password" {
  type        = string
  default     = ""
  description = "Master user password (applicable if advanced_security_options_internal_user_database_enabled set to true)"
}

variable "ebs_volume_size" {
  type        = number
  description = "EBS volumes for data storage in GB"
  default     = 0
}

variable "ebs_volume_type" {
  type        = string
  default     = "gp2"
  description = "Storage type of EBS volumes"
}

variable "ebs_iops" {
  type        = number
  default     = 0
  description = "The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type"
}

variable "encrypt_at_rest_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable encryption at rest"
}

variable "encrypt_at_rest_kms_key_id" {
  type        = string
  default     = ""
  description = "The KMS key ID to encrypt the Elasticsearch domain with. If not specified, then it defaults to using the AWS/Elasticsearch service KMS key"
}

variable "domain_endpoint_options_enforce_https" {
  type        = bool
  default     = true
  description = "Whether or not to require HTTPS"
}

variable "domain_endpoint_options_tls_security_policy" {
  type        = string
  default     = "Policy-Min-TLS-1-0-2019-07"
  description = "The name of the TLS security policy that needs to be applied to the HTTPS endpoint"
}

variable "custom_endpoint_enabled" {
  type        = bool
  description = "Whether to enable custom endpoint for the Elasticsearch domain."
  default     = false
}

variable "custom_endpoint" {
  type        = string
  description = "Fully qualified domain for custom endpoint."
  default     = ""
}

variable "custom_endpoint_certificate_arn" {
  type        = string
  description = "ACM certificate ARN for custom endpoint."
  default     = ""
}

variable "elasticsearch_instance_type" {
  type        = string
  default     = "t2.small.elasticsearch"
  description = "Elasticsearch instance type for data nodes in the cluster"
}

variable "instance_count" {
  type        = number
  description = "Number of data nodes in the cluster"
  default     = 4
}

variable "dedicated_master_enabled" {
  type        = bool
  default     = false
  description = "Indicates whether dedicated master nodes are enabled for the cluster"
}

variable "dedicated_master_count" {
  type        = number
  description = "Number of dedicated master nodes in the cluster"
  default     = 0
}

variable "dedicated_master_type" {
  type        = string
  default     = "t2.small.elasticsearch"
  description = "Instance type of the dedicated master nodes in the cluster"
}

variable "zone_awareness_enabled" {
  type        = bool
  default     = true
  description = "Enable zone awareness for Elasticsearch cluster"
}

variable "warm_enabled" {
  type        = bool
  default     = false
  description = "Whether AWS UltraWarm is enabled"
}

variable "warm_count" {
  type        = number
  default     = 2
  description = "Number of UltraWarm nodes"
}

variable "warm_type" {
  type        = string
  default     = "ultrawarm1.medium.elasticsearch"
  description = "Type of UltraWarm nodes"
}

variable "availability_zone_count" {
  type        = number
  default     = 2
  description = "Number of Availability Zones for the domain to use."
}

variable "node_to_node_encryption_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable node-to-node encryption"
}

variable "vpc_enabled" {
  type        = bool
  description = "Set to false if ES should be deployed outside of VPC."
  default     = true
}

variable "automated_snapshot_start_hour" {
  type        = number
  description = "Hour at which automated snapshots are taken, in UTC"
  default     = 0
}

variable "cognito_authentication_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable Amazon Cognito authentication with Kibana"
}

variable "cognito_user_pool_id" {
  type        = string
  default     = ""
  description = "The ID of the Cognito User Pool to use"
}

variable "cognito_identity_pool_id" {
  type        = string
  default     = ""
  description = "The ID of the Cognito Identity Pool to use"
}

variable "cognito_iam_role_arn" {
  type        = string
  default     = ""
  description = "ARN of the IAM role that has the AmazonESCognitoAccess policy attached"
}

variable "log_publishing_index_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether log publishing option for INDEX_SLOW_LOGS is enabled or not"
}

variable "log_publishing_index_cloudwatch_log_group_arn" {
  type        = string
  default     = ""
  description = "ARN of the CloudWatch log group to which log for INDEX_SLOW_LOGS needs to be published"
}

variable "log_publishing_search_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether log publishing option for SEARCH_SLOW_LOGS is enabled or not"
}

variable "log_publishing_search_cloudwatch_log_group_arn" {
  type        = string
  default     = ""
  description = "ARN of the CloudWatch log group to which log for SEARCH_SLOW_LOGS needs to be published"
}

variable "log_publishing_audit_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether log publishing option for AUDIT_LOGS is enabled or not"
}

variable "log_publishing_audit_cloudwatch_log_group_arn" {
  type        = string
  default     = ""
  description = "ARN of the CloudWatch log group to which log for AUDIT_LOGS needs to be published"
}

variable "log_publishing_application_enabled" {
  type        = bool
  default     = false
  description = "Specifies whether log publishing option for ES_APPLICATION_LOGS is enabled or not"
}

variable "log_publishing_application_cloudwatch_log_group_arn" {
  type        = string
  default     = ""
  description = "ARN of the CloudWatch log group to which log for ES_APPLICATION_LOGS needs to be published"
}

variable "iam_actions" {
  type        = list(string)
  default     = []
  description = "List of actions to allow for the IAM roles, _e.g._ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost`"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  default     = []
  description = "List of CIDR blocks to be allowed to connect to the cluster"
}

###############################################################################
# Variables - DocumentDB
###############################################################################
variable "master_password" {
  type = string
  description = "Password for the master DB user."
}

variable "master_username" {
  type = string
  description = "Username for the master DB user."
}

variable "cluster_instance_class" {
  description = "The instance class to use."
  type    = string
  default = "db.r5.large"
}

variable "cluster_instance_count" {
  description = "Number of instances to spin up per availability_zone."
  type    = number
  default = 1
}

variable "name" {
  type = string
  description = "Unique cluster identifier beginning with the specified prefix."
}

variable "backup_retention_period" {
  description = "The days to retain backups for."
  default = 7
  type    = number
}

variable "preferred_backup_window" {
  description = "The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter."
  default = "07:00-09:00"
  type    = string
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB cluster is deleted."
  default = false
  type    = bool
}

variable "storage_encrypted" {
  description = "Specifies whether the DB cluster is encrypted."
  default = true
  type    = bool
}

variable "parameters" {
  description = "additional parameters modified in parameter group."
  type        = list(map(any))
  default     = []
}

variable "apply_immediately" {
  default     = false
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window."
  type        = bool
}

variable "family" {
  default     = "docdb3.6"
  description = "Version of docdb family being created."
  type        = string
}

variable "engine" {
  default     = "docdb"
  description = "The name of the database engine to be used for this DB cluster. Only `docdb` is supported."
  type        = string
}

variable "engine_version" {
  default     = "3.6.0"
  description = "The database engine version. Updating this argument results in an outage."
  type        = string
}

###############################################################################
# Variables - MSK
###############################################################################
variable "cluster_name" {
  description = "Name of the MSK cluster."
  type        = string
}

variable "kafka_version" {
  description = "Specify the desired Kafka software version."
  type        = string
}

variable "number_of_nodes" {
  description = "The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets."
  type        = number
}

variable "volume_size" {
  description = "The size in GiB of the EBS volume for the data drive on each broker node."
  type        = number
  default     = 1000
}

variable "instance_type" {
  description = "Specify the instance type to use for the kafka brokers. e.g. kafka.m5.large."
  type        = string
}

variable "enhanced_monitoring" {
  description = "Specify the desired enhanced MSK CloudWatch monitoring level to one of three monitoring levels: DEFAULT, PER_BROKER, PER_TOPIC_PER_BROKER or PER_TOPIC_PER_PARTITION. See [Monitoring Amazon MSK with Amazon CloudWatch](https://docs.aws.amazon.com/msk/latest/developerguide/monitoring.html)."
  type        = string
  default     = "DEFAULT"
}

variable "prometheus_jmx_exporter" {
  description = "Indicates whether you want to enable or disable the JMX Exporter."
  type        = bool
  default     = false
}

variable "prometheus_node_exporter" {
  description = "Indicates whether you want to enable or disable the Node Exporter."
  type        = bool
  default     = false
}

variable "server_properties" {
  description = "A map of the contents of the server.properties file. Supported properties are documented in the [MSK Developer Guide](https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html)."
  type        = map(string)
  default     = {}
}

variable "encryption_at_rest_kms_key_arn" {
  description = "You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest. If no key is specified, an AWS managed KMS ('aws/msk' managed service) key will be used for encrypting the data at rest."
  type        = string
  default     = ""
}

variable "encryption_in_transit_client_broker" {
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT. Default value is TLS_PLAINTEXT."
  type        = string
  default     = "TLS_PLAINTEXT"
}

variable "encryption_in_transit_in_cluster" {
  description = "Whether data communication among broker nodes is encrypted. Default value: true."
  type        = bool
  default     = true
}

variable "s3_logs_bucket" {
  description = "Name of the S3 bucket to deliver logs to."
  type        = string
  default     = ""
}

variable "s3_logs_prefix" {
  description = "Prefix to append to the folder name."
  type        = string
  default     = ""
}

variable "cloudwatch_logs_group" {
  description = "Name of the Cloudwatch Log Group to deliver logs to."
  type        = string
  default     = ""
}

variable "firehose_logs_delivery_stream" {
  description = "Name of the Kinesis Data Firehose delivery stream to deliver logs to."
  type        = string
  default     = ""
}

###############################################################################
# Variables - RDS
###############################################################################
variable "db_identifier" {
  description = "The name of the RDS instance."
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created."
}

variable "db_username" {
  description = "Username for the master DB user."
  type        = string
}

variable "db_password" {
  description = "Password for the master DB user."
  type        = string
  default     = ""
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance."
}

variable "db_engine" {
  description = "The database engine to use."
}

variable "db_engine_version" {
  description = "The engine version to use."
}

variable "db_allocated_storage" {
  description = "The amount of allocated storage."
}

variable "db_multi_az" {
  description = "Does the DB need multi-az for High Availability."
}

variable "rds_backup_retention_period" {
  description = "The days to retain backups for."
}

variable "rds_storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted."
}

variable "rds_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted."
}

###############################################################################
# Variables - S3 Bucket
###############################################################################
variable "bucket_name" {
  description = "Name of the S3 bucket to be created."
  type        = string
}

variable "versioning_enabled" {
  description = "A boolean that indicates if versioning to be enabled in S3 bucket"
  type        = bool
  default     = false
}

variable "acl" {
  description = "The canned ACL to apply. Defaults to 'private'."
  type        = string
  default     = "private"
}

variable "force_destroy_bucket" {
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = true
}
