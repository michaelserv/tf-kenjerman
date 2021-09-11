variable "group_subnets" {
  type    = list(string)
  default = []
}

variable "cluster_security_group" {
  type = list(string)
}

variable "master_password" {
  type = string
}

variable "master_username" {
  type = string
}

variable "cluster_instance_class" {
  type    = string
  default = "db.r5.large"
}

variable "cluster_instance_count" {
  type    = number
  default = 1
}

variable "name" {
  type = string
}

variable "backup_retention_period" {
  default = 7
  type    = number
}

variable "preferred_backup_window" {
  default = "07:00-09:00"
  type    = string
}

variable "skip_final_snapshot" {
  default = false
  type    = bool
}

variable "storage_encrypted" {
  default = true
  type    = bool
}

variable "parameters" {
  description = "additional parameters modified in parameter group"
  type        = list(map(any))
  default     = []
}

variable "apply_immediately" {
  default     = false
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window."
  type        = bool
}

variable "family" {
  default     = "docdb3.6"
  description = "Version of docdb family being created"
  type        = string
}

variable "engine" {
  default     = "docdb"
  description = "The name of the database engine to be used for this DB cluster. Only `docdb` is supported."
  type        = string
}

variable "engine_version" {
  default     = "3.6.0"
  description = "The database engine version. Updating this argument results in an outage."
  type        = string
}
