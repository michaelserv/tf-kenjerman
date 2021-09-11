## Summary

Terraform module to create S3 bucket

## Usage

```
module "s3_bucket" {
  source = "../modules/s3_bucket"

  bucket_name = var.bucket_name
  acl         = var.acl
  tags        = local.tags

  versioning = {
    enabled = var.versioning_enabled
  }
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acl | (Optional) The canned ACL to apply. Defaults to 'private'. | `string` | `private` | no |
| bucket\_name | Name of the S3 bucket to be created. | `string` | `` | yes |
| force\_destroy\_bucket | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable. | `bool` | `true` | no |
| versioning | A boolean that indicates if versioning to be enabled in S3 bucket. | `bool` | `{}` | no |
| tags | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_id | The Id of the s3 bucket. |
