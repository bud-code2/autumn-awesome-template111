variable "name_prefix" {
  type = string
}

variable "force_destroy" {
  type = bool
}

variable "log_expiration_days" {
  type = number
}

variable "noncurrent_version_transition_days" {
  type = number
}

variable "noncurrent_version_storage_class" {
  type = string
}
