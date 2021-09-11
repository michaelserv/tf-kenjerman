## Summary

Terraform code to create Hoot resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_account\_id | (Required) AWS Account ID. | string | n/a | yes |
| region | (Required) Region where resources will be created. | string | `ap-southeast-2` | yes |
| environment | (Optional) The name of the environment, e.g. Production, Development, etc. | string | `Development` | yes |

## Inputs for VPC

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc\_name | (Required) VPC Name. | string | n/a | yes |
| vpc\_cidr | (Required) VPC CIDR block. | string | n/a | yes |
| map\_public\_ip\_on\_launch | (Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false. | string | `false` | yes |
| public\_cidr\_a | (Required) Public CIDR block A. | string | n/a | yes |
| public\_cidr\_b | (Required) Public CIDR block B. | string | n/a | yes |
| private\_cidr\_a | (Required) Private CIDR block A. | string | n/a | yes |
| private\_cidr\_b | (Required) Private CIDR block B. | string | n/a | yes |

## Inputs for Security Groups

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc\_id | VPC id where the load balancer and other resources will be deployed. | `string` | `null` | yes |
| source\_address | (Optional) The address to allow to communicate with ALB. | `string` | `0.0.0.0/0` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Inputs for ALB

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_logs | Map containing access logging configuration for load balancer. | `map(string)` | `{}` | no |
| create\_lb | Controls if the Load Balancer should be created | `bool` | `true` | no |
| drop\_invalid\_header\_fields | Indicates whether invalid header fields are dropped in application load balancers. Defaults to false. | `bool` | `false` | no |
| enable\_cross\_zone\_load\_balancing | Indicates whether cross zone load balancing should be enabled in application load balancers. | `bool` | `false` | no |
| enable\_deletion\_protection | If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false. | `bool` | `false` | no |
| enable\_http2 | Indicates whether HTTP/2 is enabled in application load balancers. | `bool` | `true` | no |
| extra\_ssl\_certs | A list of maps describing any extra SSL certificates to apply to the HTTPS listeners. Required key/values: certificate\_arn, https\_listener\_index (the index of the listener within https\_listeners which the cert applies toward). | `list(map(string))` | `[]` | no |
| http\_tcp\_listeners | A list of maps describing the HTTP listeners or TCP ports for this ALB. Required key/values: port, protocol. Optional key/values: target\_group\_index (defaults to http\_tcp\_listeners[count.index]) | `any` | `[]` | no |
| https\_listener\_rules | A list of maps describing the Listener Rules for this ALB. Required key/values: actions, conditions. Optional key/values: priority, https\_listener\_index (default to https\_listeners[count.index]) | `any` | `[]` | no |
| https\_listeners | A list of maps describing the HTTPS listeners for this ALB. Required key/values: port, certificate\_arn. Optional key/values: ssl\_policy (defaults to ELBSecurityPolicy-2016-08), target\_group\_index (defaults to https\_listeners[count.index]) | `any` | `[]` | no |
| idle\_timeout | The time in seconds that the connection is allowed to be idle. | `number` | `60` | no |
| internal | Boolean determining if the load balancer is internal or externally facing. | `bool` | `false` | no |
| ip\_address\_type | The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack. | `string` | `"ipv4"` | no |
| lb\_tags | A map of tags to add to load balancer | `map(string)` | `{}` | no |
| listener\_ssl\_policy\_default | The security policy if using HTTPS externally on the load balancer. [See](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-policy-table.html). | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| load\_balancer\_create\_timeout | Timeout value when creating the ALB. | `string` | `"10m"` | no |
| load\_balancer\_delete\_timeout | Timeout value when deleting the ALB. | `string` | `"10m"` | no |
| load\_balancer\_type | The type of load balancer to create. Possible values are application or network. | `string` | `"application"` | no |
| load\_balancer\_update\_timeout | Timeout value when updating the ALB. | `string` | `"10m"` | no |
| name | The resource name and Name tag of the load balancer. | `string` | `null` | no |
| name\_prefix | The resource name prefix and Name tag of the load balancer. Cannot be longer than 6 characters | `string` | `null` | no |
| security\_groups | The security groups to attach to the load balancer. e.g. ["sg-edcd9784","sg-edcd9785"] | `list(string)` | `[]` | no |
| subnet\_mapping | A list of subnet mapping blocks describing subnets to attach to network load balancer | `list(map(string))` | `[]` | no |
| subnets | A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f'] | `list(string)` | `null` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| target\_group\_tags | A map of tags to add to all target groups | `map(string)` | `{}` | no |
| target\_groups | A list of maps containing key/value pairs that define the target groups to be created. Order of these maps is important and the index of these are to be referenced in listener definitions. Required key/values: name, backend\_protocol, backend\_port | `any` | `[]` | no |
| vpc\_id | VPC id where the load balancer and other resources will be deployed. | `string` | `null` | no |

## Inputs for RDS

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
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

## Inputs for ECS (EC2)

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the app. | `string` | n/a | yes |
| private\_subnets | The IDs of the Private Subnets. | `list(any)` | n/a | yes |
| ecs\_sg\_id | The Security Group ID for ECS. | `string` | n/a | yes |
| target\_group\_arn | The ARN of the Target Group. | `string` | n/a | yes |
| tags | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |
| container\_name | The name of the container. | `string` | n/a | yes |
| container\_port | The Port number for the container to use. | `number` | n/a | yes |
| desired\_count | Desired number of tasks to run. | `number` | `1` | no |
| max\_count\_ec2 | Max number of ec2 to run. | `number` | `3` | no |
| min\_count\_ec2 | Minimum number of ec2 to run. | `number` | `2` | no |
| desired\_count\_ec2 | Desired number of ec2 to run. | `number` | `2` | no |
| ec2\_instance\_type | EC2 instance type to use. | `string` | `"t3.micro"` | no |
| container\_definitions | A list of valid container definitions provided as a single valid JSON document. | `any` | n/a | yes |

## Inputs for Elasticache

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| parameter | A list of Redis parameters to apply. Note that parameters may differ from one Redis family to another | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| existing\_security\_groups | List of existing Security Group IDs to place the cluster into. | `list(string)` | `[]` | yes |
| transit\_encryption\_enabled | Whether to enable encryption in transit. If this is enabled, use the [following guide](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/in-transit-encryption.html#connect-tls) to access redis | `bool` | `true` | no |
| at\_rest\_encryption\_enabled | Enable encryption at rest | `bool` | `false` | no |
| engine\_version | Redis engine version | `string` | `"4.0.10"` | no |
| availability\_zones | Availability zone IDs | `list(string)` | `[]` | no |
| cluster\_size | Number of nodes in cluster. *Ignored when `cluster_mode_enabled` == `true`* | `number` | `1` | no |
| instance\_type | Elastic cache instance type | `string` | `"cache.t2.micro"` | no |
| family | Redis family | `string` | `"redis4.0"` | no |
| subnets | Subnet IDs | `list(string)` | `[]` | no |
| vpc\_id | VPC ID | `string` | n/a | yes |

## Inputs for Cloudfront

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| domain\_name | The DNS domain name of either the S3 bucket, or web site of your custom origin. | string | n/a | yes |
| origin\_id | A unique identifier for the origin. | string | n/a | yes |
| acm\_certificate\_arn | SSL certificate ARN. The certificate must be present in AWS Certificate Manager.. | string | n/a | yes |
| tags | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Inputs for Basion Host

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| bastioninstancetype | Bastion Host Instance Type. | `string` | n/a | yes |
| origin\_id | A unique identifier for the origin. | `string` | `"t3.micro"` | no |
| ec2keypairbastion | Bastion Host Key Pair. | `string` | n/a | yes |
| public\_subnets | The IDs of the Public Subnets. | `list(any)` | n/a | yes |
| bastion\_sg\_id | The Security Group ID for the Bastion Host. | `string` | n/a | yes |
| tags | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

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

## Outputs

| Name | Description |
|------|-------------|
| vpc\_id | The ID of the VPC. |
| public\_subnet\_a\_id | The ID of the Public Subnet A. |
| public\_subnet\_b\_id | The ID of the Public Subnet B. |
| private\_subnet\_a\_id | The ID of the Private Subnet A. |
| private\_subnet\_b\_id | The ID of the Private Subnet B. |
| private\_subnets | List of IDs of private subnets. |
| public\_subnets | List of IDs of public subnets. |
| alb\_sg\_id | The ID of the ALB Security Group. |
| ecs\_sg\_id | The ID of the ECS Security Group. |
| rds\_sg\_id | The ID of the RDS Security Group. |
| http\_tcp\_listener\_arns | The ARN of the TCP and HTTP load balancer listeners created. |
| http\_tcp\_listener\_ids | The IDs of the TCP and HTTP load balancer listeners created. |
| https\_listener\_arns | The ARNs of the HTTPS load balancer listeners created. |
| https\_listener\_ids | The IDs of the load balancer listeners created. |
| target\_group\_arn\_suffixes | ARN suffixes of our target groups - can be used with CloudWatch. |
| target\_group\_arns | ARNs of the target groups. Useful for passing to your Auto Scaling group. |
| target\_group\_attachments | ARNs of the target group attachment IDs. |
| target\_group\_names | Name of the target group. Useful for passing to your CodeDeploy Deployment Group. |
| this\_lb\_arn | The ID and ARN of the load balancer we created. |
| this\_lb\_arn\_suffix | ARN suffix of our load balancer - can be used with CloudWatch. |
| this\_lb\_dns\_name | The DNS name of the load balancer. |
| this\_lb\_id | The ID and ARN of the load balancer we created. |
| this\_lb\_zone\_id | The zone\_id of the load balancer to assist with creating DNS records. |
| cluster\_id | EMR cluster ID. |
| cluster\_name | EMR cluster name. |
| ec2\_role | Role name of EMR EC2 instances so users can attach more policies. |
| master\_public\_dns | Master public DNS. |
| ecs\_task\_execution\_role\_arn | The ARN for the ECS task execution role. |
| ecs\_task\_role\_arn | The ARN for the ECS task role. |
| rds\_address | The hostname of the RDS instance. |
| ecs\_cluster\_arn | The Amazon Resource Name (ARN) that identifies the cluster. |
| ecs\_service\_cluster | Amazon Resource Name (ARN) of cluster which the service runs on. |
| ecs\_service\_id | ARN that identifies the service. |
| ecs\_service\_name | Name of the service. |
| ecs\_td\_arn | Full ARN of the Task Definition (including both family and revision) |
| ecs\_td\_family | The family of the Task Definition. |
| ecs\_td\_revision | The revision of the Task Definition. |
| endpoint | Redis primary endpoint |
| id | Redis cluster ID |
| member\_clusters | Redis cluster members |
| port | Redis port |
| cloudfront\_arn | The ARN (Amazon Resource Name) for the distribution. |
| cloudfront\_id | The identifier for the distribution. |
| cloudfront\_domain\_name | The domain name corresponding to the distribution. |
| BastionInstanceIP | Public IP of the bastion host. |
| domain\_arn | ARN of the Elasticsearch domain |
| domain\_id | Unique identifier for the Elasticsearch domain |
| domain\_name | Name of the Elasticsearch domain |
| domain\_endpoint | Domain-specific endpoint used to submit index, search, and data upload requests |
| kibana\_endpoint | Domain-specific endpoint for Kibana without https scheme |
| elasticsearch\_user\_iam\_role\_name | The name of the IAM role to allow access to Elasticsearch cluster |
| elasticsearch\_user\_iam\_role\_arn | The ARN of the IAM role to allow access to Elasticsearch cluster |
