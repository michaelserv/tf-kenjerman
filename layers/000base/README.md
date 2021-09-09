## Summary

Terraform code to create EKS VPC resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_account\_id | (Required) AWS Account ID. | string | n/a | yes |
| region | (Required) Region where resources will be created. | string | `"ap-southeast-2"` | no |
| environment | (Optional) The name of the environment, e.g. Production, Development, etc. | string | `"Development"` | no |

## Inputs for VPC module

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vpc\_name | Name to be used on all the VPC resources as identifier. | string | `"VPC"` | no |
| vpc\_cidr | The CIDR block for the VPC. | string | `"10.0.0.0/16"` | no |
| private\_subnets | A list of private subnets inside the VPC. | list(any) | `["10.0.1.0/24", "10.0.2.0/24"]` | no |
| public\_subnets | A list of public subnets inside the VPC. | list(any) | `["10.0.4.0/24", "10.0.5.0/24"]` | no |
| database\_subnets | A list of database subnets. | list(any) | `["10.0.21.0/24", "10.0.22.0/24"]` | no |
| enable\_nat\_gateway | Should be true if you want to provision NAT Gateways for each of your private networks. | bool | `true` | no |
| single\_nat\_gateway | Should be true if you want to provision a single shared NAT Gateway across all of your private networks. | bool | `true` | no |
| enable\_dns\_hostnames | Should be true to enable DNS hostnames in the VPC. | bool | `true` | no |
| eks\_cluster\_name | Name of the EKS Cluster. | string | `"eks-staging-cluster"` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc\_id | The ID of the VPC. |
| private\_subnets | List of IDs of private subnets. |
| public\_subnets | List of IDs of public subnets. |
| data\_subnets | List of IDs of data subnets. |
| eks\_cluster\_name | Name of the EKS Cluster. |
