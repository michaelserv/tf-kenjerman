## Summary

Terraform code to create your compute resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_account\_id | AWS Account ID. | string | n/a | yes |
| region | Region where resources will be created. | string | `"ap-southeast-2"` | no |
| environment | The name of the environment, e.g. Production, Development, etc. | string | `"Development"` | no |
| instance_type | The instance type to use for the instance. | `string` | `t3.micro` | no |
| key_name | Key name of the Key Pair to use for the instance. | `string` | n/a | yes |
| user_data | User data to provide when launching the instance. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| bastion\_ip | The public IP address assigned to the instance. |
