## Terraform AWS DocumentDB Cluster

This terraform module creates a documentDB cluster.

## Inputs

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

## Outputs

| Name | Description |
|------|-------------|
|------|-------------|
| arn | Amazon Resource Name (ARN) of the DocumentDB cluster. |
| cluster_members | List of DocDB Instances that are a part of this cluster. |
| cluster_resource_id | The DocDB Cluster Resource ID. |
| endpoint | The DNS address of the DocDB instance. |
| hosted_zone_id | The Route53 Hosted Zone ID of the endpoint. |
| id | The DocDB Cluster Identifier. |
| reader_endpoint | A read-only endpoint for the DocDB cluster, automatically load-balanced across replicas. |
