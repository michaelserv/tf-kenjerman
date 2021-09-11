###############################################################################
# Variables - S3
###############################################################################
variable "bucket_name" {
  description = "Name of the S3 bucket to be created."
}

variable "force_destroy_bucket" {
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = true
}

variable "acl" {
  description = "(Optional) The canned ACL to apply. Defaults to 'private'."
  type        = string
  default     = "private"
}

variable "versioning" {
  description = "A boolean that indicates if versioning to be enabled in S3 bucket"
  default     = {}
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
