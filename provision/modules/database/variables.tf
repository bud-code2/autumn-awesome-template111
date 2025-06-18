variable "name_prefix" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "storage_type" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_name" {
  type = string
}

variable "backup_retention_period" {
  type = number
}

variable "vpc_security_group_ids" {
  type    = list(string)
  default = []
}

variable "cloudwatch_log_retention_in_days" {
  type        = number
  default     = 7
  description = "Number of days to retain CloudWatch logs"
}

variable "enabled_cloudwatch_logs_exports" {
  type = list(string)
}
