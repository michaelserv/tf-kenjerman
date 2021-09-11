###############################################################################
# S3 Buckets
###############################################################################
resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  acl           = var.acl
  force_destroy = var.force_destroy_bucket
  tags          = var.tags

  dynamic "versioning" {
    for_each = length(keys(var.versioning)) == 0 ? [] : [var.versioning]

    content {
      enabled = lookup(versioning.value, "enabled", null)
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
