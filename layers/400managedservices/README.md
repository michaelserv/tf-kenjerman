## Summary

Terraform code to create your AWS Managed services (Elasticsearch, DocumentDB, MSK, RDS, and S3 bucket).

# Inputs
## Inputs for environment

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_account\_id | AWS Account ID. | string | n/a | yes |
| region | Region where resources will be created. | string | `ap-southeast-2` | yes |
| environment | The name of the environment, e.g. Production, Development, etc. | string | `Development` | yes |

## Inputs for Elasticsearch

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_iam\_service\_linked\_role | Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info | `bool` | `true` | no |
| iam\_role\_max\_session\_duration | The maximum session duration (in seconds) for the user role. Can have a value from 1 hour to 12 hours | `number` | `3600` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| es\_name | Name of the Elasticsearch domain. | `string` | `hoot` | no |
| iam\_authorizing\_role\_arns | List of IAM role ARNs to permit to assume the Elasticsearch user role | `list(string)` | `[]` | no |
| iam\_role\_arns | List of IAM role ARNs to permit access to the Elasticsearch domain | `list(string)` | `[]` | no |
| aws\_ec2\_service\_name | AWS EC2 Service Name | `list(string)` | `["ec2.amazonaws.com"]` | no |
| elasticsearch\_version | Version of Elasticsearch to deploy (\_e.g.\_ `7.4`, `7.1`, `6.8`, `6.7`, `6.5`, `6.4`, `6.3`, `6.2`, `6.0`, `5.6`, `5.5`, `5.3`, `5.1`, `2.3`, `1.5` | `string` | `7.4` | no |
| advanced\_options | Key-value string pairs to specify advanced configuration options | `map(string)` | `{}` | no |
| advanced\_security\_options\_enabled | AWS Elasticsearch Kibana enchanced security plugin enabling (forces new resource) | `bool` | `false` | no |
| advanced\_security\_options\_internal\_user\_database\_enabled | Whether to enable or not internal Kibana user database for ELK OpenDistro security plugin | `bool` | `false` | no |
| advanced\_security\_options\_master\_user\_arn | ARN of IAM user who is to be mapped to be Kibana master user (applicable if advanced\_security\_options\_internal\_user\_database\_enabled set to false) | `string` | `""` | no |
| advanced\_security\_options\_master\_user\_name | Master user username (applicable if advanced\_security\_options\_internal\_user\_database\_enabled set to true) | `string` | `""` | no |
| advanced\_security\_options\_master\_user\_password | Master user password (applicable if advanced\_security\_options\_internal\_user\_database\_enabled set to true) | `string` | `""` | no |
| ebs\_volume\_size | EBS volumes for data storage in GB | `number` | `0` | no |
| ebs\_volume\_type | Storage type of EBS volumes | `string` | `gp2` | no |
| ebs\_iops | The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type | `number` | `0` | no |
| encrypt\_at\_rest\_enabled | Whether to enable encryption at rest | `bool` | `true` | no |
| encrypt\_at\_rest\_kms\_key\_id | The KMS key ID to encrypt the Elasticsearch domain with. If not specified, then it defaults to using the AWS/Elasticsearch service KMS key | `string` | `""` | no |
| domain\_endpoint\_options\_enforce\_https | Whether or not to require HTTPS | `bool` | `true` | no |
| domain\_endpoint\_options\_tls\_security\_policy | The name of the TLS security policy that needs to be applied to the HTTPS endpoint | `string` | `"Policy-Min-TLS-1-0-2019-07"` | no |
| custom\_endpoint\_enabled | Whether to enable custom endpoint for the Elasticsearch domain. | `bool` | `false` | no |
| custom\_endpoint | Fully qualified domain for custom endpoint. | `string` | `""` | no |
| custom\_endpoint\_certificate\_arn | ACM certificate ARN for custom endpoint. | `string` | `""` | no |
| instance\_type | Elasticsearch instance type for data nodes in the cluster | `string` | `"t2.small.elasticsearch"` | no |
| instance\_count | Number of data nodes in the cluster. | `number` | `4` | no |
| dedicated\_master\_enabled | Indicates whether dedicated master nodes are enabled for the cluster. | `bool` | `false` | no |
| dedicated\_master\_count | Number of dedicated master nodes in the cluster. | `number` | `0` | no |
| dedicated\_master\_type | Instance type of the dedicated master nodes in the cluster | `string` | `"t2.small.elasticsearch"` | no |
| zone\_awareness\_enabled | Enable zone awareness for Elasticsearch cluster. | `bool` | `true` | no |
| warm\_enabled | Whether AWS UltraWarm is enabled. | `bool` | `false` | no |
| warm\_count | Number of UltraWarm nodes. | `number` | `2` | no |
| warm\_type | Type of UltraWarm nodes. | `string` | `"ultrawarm1.medium.elasticsearch"` | no |
| availability\_zone\_count | Number of Availability Zones for the domain to use. | `number` | `2` | no |
| node\_to\_node\_encryption\_enabled | Whether to enable node-to-node encryption. | `bool` | `false` | no |
| vpc\_enabled | Set to false if ES should be deployed outside of VPC. | `bool` | `true` | no |
| existing\_security\_groups | List of existing Security Group IDs to place the Elasticsearch domain into. | `list(string)` | `[]` | yes |
| vpc\_enabled | Set to false if ES should be deployed outside of VPC. | `list(string)` | `[]` | no |
| subnet\_ids | VPC Subnet IDs.  `list(string)` | `[]` | no |
| automated\_snapshot\_start\_hour | Hour at which automated snapshots are taken, in UTC | `number` | `0` | no |
| cognito\_authentication\_enabled | Whether to enable Amazon Cognito authentication with Kibana. | `bool` | `false` | no |
| cognito\_user\_pool\_id | The ID of the Cognito User Pool to use. | `string` | `""` | no |
| cognito\_identity\_pool\_id | The ID of the Cognito Identity Pool to use | `string` | `""` | no |
| cognito\_iam\_role\_arn | ARN of the IAM role that has the AmazonESCognitoAccess policy attached. | `string` | `""` | no |
| log\_publishing\_index\_enabled | Specifies whether log publishing option for INDEX\_SLOW\_LOGS is enabled or not. | `bool` | `false` | no |
| log\_publishing\_index\_cloudwatch\_log\_group\_arn | ARN of the CloudWatch log group to which log for INDEX\_SLOW\_LOGS needs to be published. | `string` | `""` | no |
| log\_publishing\_search\_enabled | Specifies whether log publishing option for SEARCH\_SLOW\_LOGS is enabled or not | `bool` | `false` | no |
| log\_publishing\_search\_cloudwatch\_log\_group\_arn | ARN of the CloudWatch log group to which log for SEARCH\_SLOW\_LOGS needs to be published. | `string` | `""` | no |
| log\_publishing\_audit\_enabled | Specifies whether log publishing option for AUDIT\_LOGS is enabled or not | `bool` | `false` | no |
| log\_publishing\_audit\_cloudwatch\_log\_group\_arn | ARN of the CloudWatch log group to which log for AUDIT\_LOGS needs to be published. | `string` | `""` | no |
| log\_publishing\_application\_enabled | Specifies whether log publishing option for ES\_APPLICATION\_LOGS is enabled or not | `bool` | `false` | no |
| log\_publishing\_application\_cloudwatch\_log\_group\_arn | ARN of the CloudWatch log group to which log for ES\_APPLICATION\_LOGS needs to be published. | `string` | `""` | no |
| iam\_actions | List of actions to allow for the IAM roles, \_e.g.\_ `es:ESHttpGet`, `es:ESHttpPut`, `es:ESHttpPost` | `list(string)` | `[]` | no |
| allowed\_cidr\_blocks | List of CIDR blocks to be allowed to connect to the cluster. | `list(string)` | `[]` | no |

## Inputs for DocumentDB

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| apply\_immediately | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. | bool | `"false"` | no |
| backup\_retention\_period | The days to retain backups for. | number | `"7"` | no |
| cluster\_instance\_class | The instance class to use | string | `"db.r5.large"` | no |
| cluster\_instance\_count | Number of instances to spin up per availability_zone. | number | `"1"` | no |
| master\_password | Password for the master DB user. | string | n/a | yes |
| master\_username | Username for the master DB user. | string | n/a | yes |
| name | Unique cluster identifier beginning with the specified prefix. | string | n/a | yes |
| parameters | additional parameters modified in parameter group | list(map(any)) | `[]` | no |
| preferred\_backup\_window | The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter. | string | `"07:00-09:00"` | no |
| skip\_final\_snapshot | Determines whether a final DB snapshot is created before the DB cluster is deleted. | bool | `"false"` | no |
| storage\_encrypted | Specifies whether the DB cluster is encrypted. | bool | `"true"` | no |

## Inputs for MSK

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_subnets | A list of subnets to connect to in client VPC | `list(string)` | n/a | yes |
| cloudwatch\_logs\_group | Name of the Cloudwatch Log Group to deliver logs to. | `string` | `""` | no |
| cluster\_name | Name of the MSK cluster. | `string` | n/a | yes |
| encryption\_at\_rest\_kms\_key\_arn | You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest. If no key is specified, an AWS managed KMS ('aws/msk' managed service) key will be used for encrypting the data at rest. | `string` | `""` | no |
| encryption\_in\_transit\_client\_broker | Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS\_PLAINTEXT, and PLAINTEXT. Default value is TLS\_PLAINTEXT. | `string` | `"TLS_PLAINTEXT"` | no |
| encryption\_in\_transit\_in\_cluster | Whether data communication among broker nodes is encrypted. Default value: true. | `bool` | `true` | no |
| enhanced\_monitoring | Specify the desired enhanced MSK CloudWatch monitoring level to one of three monitoring levels: DEFAULT, PER\_BROKER, PER\_TOPIC\_PER\_BROKER or PER\_TOPIC\_PER\_PARTITION. See [Monitoring Amazon MSK with Amazon CloudWatch](https://docs.aws.amazon.com/msk/latest/developerguide/monitoring.html). | `string` | `"DEFAULT"` | no |
| extra\_security\_groups | A list of extra security groups to associate with the elastic network interfaces to control who can communicate with the cluster. | `list(string)` | `[]` | no |
| firehose\_logs\_delivery\_stream | Name of the Kinesis Data Firehose delivery stream to deliver logs to. | `string` | `""` | no |
| instance\_type | Specify the instance type to use for the kafka brokers. e.g. kafka.m5.large. | `string` | n/a | yes |
| kafka\_version | Specify the desired Kafka software version. | `string` | n/a | yes |
| number\_of\_nodes | The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets. | `number` | n/a | yes |
| prometheus\_jmx\_exporter | Indicates whether you want to enable or disable the JMX Exporter. | `bool` | `false` | no |
| prometheus\_node\_exporter | Indicates whether you want to enable or disable the Node Exporter. | `bool` | `false` | no |
| s3\_logs\_bucket | Name of the S3 bucket to deliver logs to. | `string` | `""` | no |
| s3\_logs\_prefix | Prefix to append to the folder name. | `string` | `""` | no |
| server\_properties | A map of the contents of the server.properties file. Supported properties are documented in the [MSK Developer Guide](https://docs.aws.amazon.com/msk/latest/developerguide/msk-configuration-properties.html). | `map(string)` | `{}` | no |
| tags | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| volume\_size | The size in GiB of the EBS volume for the data drive on each broker node. | `number` | `1000` | no |

## Inputs for RDS

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| rds\_sg\_id | The Security Group ID for RDS. | `string` | n/a | yes |
| private\_subnets | The IDs of the Private Subnets. | `list(any)` | n/a | yes |
| tags | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| db\_identifier | The name of the RDS instance. | `string` | n/a | yes |
| db\_name | The name of the database to create when the DB instance is created. | `string` | `null` | yes |
| db\_username | Username for the master DB user. | `string` | n/a | yes |
| db\_password | Password for the master DB user. | `string` | `""` | yes |
| db\_instance\_class | The instance type of the RDS instance. | `string` | n/a | yes |
| db\_engine | The database engine to use. | `string` | n/a | yes |
| db\_engine\_version | The engine version to use. | `string` | n/a | yes |
| db\_allocated\_storage | The amount of allocated storage. | `string` | n/a | yes |
| db_multi_az | Does the DB need multi-az for High Availability. | `bool` | `false` | no |
| backup_retention_period | The days to retain backups for. | `number` | `null` | no |
| storage_encrypted | Specifies whether the DB instance is encrypted. | `bool` | `true` | no |
| skip_final_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted. | `bool` | `true` | no |

## Inputs for S3 Bucket

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| acl | (Optional) The canned ACL to apply. Defaults to 'private'. | `string` | `private` | no |
| bucket\_name | Name of the S3 bucket to be created. | `string` | `` | yes |
| force\_destroy\_bucket | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `true` | no |
| versioning | A boolean that indicates if versioning to be enabled in S3 bucket. | `bool` | `{}` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

# Outputs

## Outputs for Elasticsearch

| Name | Description |
|------|-------------|
| elasticsearch\_domain\_arn | ARN of the Elasticsearch domain. |
| elasticsearch\_domain\_id | Unique identifier for the Elasticsearch domain. |
| elasticsearch\_domain\_name | Name of the Elasticsearch domain. |
| elasticsearch\_domain\_endpoint | Domain-specific endpoint used to submit index, search, and data upload requests. |
| elasticsearch\_kibana\_endpoint | Domain-specific endpoint for Kibana without https scheme. |

## Outputs for DocumentDB

| Name | Description |
|------|-------------|
| documentdb_arn | Amazon Resource Name (ARN) of the DocumentDB cluster. |
| documentdb_cluster_members | List of DocDB Instances that are a part of this cluster. |
| documentdb_cluster_resource_id | The DocDB Cluster Resource ID. |
| documentdb_endpoint | The DNS address of the DocDB instance. |
| documentdb_hosted_zone_id | The Route53 Hosted Zone ID of the endpoint. |
| documentdb_id | The DocDB Cluster Identifier. |
| documentdb_reader_endpoint | A read-only endpoint for the DocDB cluster, automatically load-balanced across replicas. |

## Outputs for MSK

| Name | Description |
|------|-------------|
| msk_cluster_arn | Amazon Resource Name (ARN) of the MSK cluster. |
| msk_cluster_bootstrap_brokers | A comma separated list of one or more hostname:port pairs of kafka brokers suitable to boostrap connectivity to the kafka cluster. Only contains value if client_broker encryption in transit is set o PLAINTEXT or TLS_PLAINTEXT. |
| msk_cluster_bootstrap_brokers_tls | A comma separated list of one or more DNS names (or IPs) and TLS port pairs kafka brokers suitable to boostrap connectivity to the kafka cluster. Only contains value if client_broker encryption in transit is set to TLS_PLAINTEXT or TLS. |
| msk_cluster_current_version | Current version of the MSK Cluster used for updates. |
| msk_cluster_encryption_at_rest_kms_key_arn | The ARN of the KMS key used for encryption at rest of the broker data volumes. |
| msk_cluster_zookeeper_connect_string | A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster. |

## Outputs for RDS

| Name | Description |
|------|-------------|
| rds_address | The hostname of the RDS instance. |

## Outputs for MSK

| Name | Description |
|------|-------------|
| s3_bucket_id | The Id of the s3 bucket. |
