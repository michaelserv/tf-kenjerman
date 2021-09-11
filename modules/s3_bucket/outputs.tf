###############################################################################
# S3 Bucket Output
###############################################################################
output "bucket_id" {
  description = "The Id of the s3 bucket."
  value       = aws_s3_bucket.bucket.id
}
