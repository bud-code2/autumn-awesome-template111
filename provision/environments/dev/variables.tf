variable "project" {
  type    = string
  default = "autumn"
}

variable "profile" {
  type    = string
  default = "default"
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "db_port" {
  type    = number
  default = 5432
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

# variable "db_username_app" {
#   type = string
# }

# variable "db_password_app" {
#   type = string
# }

variable "db_schema" {
  type = string
}

variable "opennext_shell" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "subdomain_name" {
  type = string
}

variable "system_sender_email" {
  type = string
}
