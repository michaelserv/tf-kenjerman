## Terraform AWS MSK Cluster

Terraform module which creates [Msk Kafka Cluster](https://aws.amazon.com/msk/) on AWS.

## Inputs

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

## Outputs

| Name | Description |
|------|-------------|
| arn | Amazon Resource Name (ARN) of the MSK cluster. |
| bootstrap\_brokers | A comma separated list of one or more hostname:port pairs of kafka brokers suitable to boostrap connectivity to the kafka cluster. Only contains value if client\_broker encryption in transit is set o PLAINTEXT or TLS\_PLAINTEXT. |
| bootstrap\_brokers\_tls | A comma separated list of one or more DNS names (or IPs) and TLS port pairs kafka brokers suitable to boostrap connectivity to the kafka cluster. Only contains value if client\_broker encryption in transit is set to TLS\_PLAINTEXT or TLS. |
| current\_version | Current version of the MSK Cluster used for updates, e.g. K13V1IB3VIYZZH |
| default\_security\_group | Msk cluster default security group id. |
| encryption\_at\_rest\_kms\_key\_arn | The ARN of the KMS key used for encryption at rest of the broker data volumes. |
| zookeeper\_connect\_string | A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster. |
