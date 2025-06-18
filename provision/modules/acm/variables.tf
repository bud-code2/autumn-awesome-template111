variable "name_prefix" {
  type = string
}

variable "subdomain" {
  type = string
}

variable "route53_zone_id" {
  type        = string
  description = "The ID of the Route 53 hosted zone"
}
