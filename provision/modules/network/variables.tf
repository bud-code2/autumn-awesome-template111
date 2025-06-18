variable "name_prefix" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnets" {
  type = map(map(string))
}

variable "private_subnets" {
  type = map(map(string))
}

variable "region" {
  type = string
}

variable "vpc_flow_logs_bucket_arn" {
  type = string
}

variable "vpc_endpoint_sg_ids" {
  type = list(string)
}

variable "nat_placement_az_list" {
  type = list(string)
}
