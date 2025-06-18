locals {
  name_prefix = "${var.project}-dev"
  subdomain   = "${var.subdomain_name}.${var.domain_name}"
  app_url     = "https://${local.subdomain}"

  # --- VPC Settings ---
  vpc_cidr = "10.0.0.0/16"

  public_subnets = {
    "1a" = {
      cidr_block = cidrsubnet(local.vpc_cidr, 4, 0)
      az         = "ap-southeast-1a"
    }
    "1c" = {
      cidr_block = cidrsubnet(local.vpc_cidr, 4, 1)
      az         = "ap-southeast-1c"
    }
  }

  private_subnets = {
    "1a" = {
      cidr_block = cidrsubnet(local.vpc_cidr, 4, 2)
      az         = "ap-southeast-1a"
    }
    "1c" = {
      cidr_block = cidrsubnet(local.vpc_cidr, 4, 3)
      az         = "ap-southeast-1c"
    }
  }

  nat_placement_az_list = ["1a"]

  # --- Logging Settings ---
  force_destroy                      = true
  log_expiration_days                = 365 * 5
  noncurrent_version_storage_class   = "INTELLIGENT_TIERING"
  noncurrent_version_transition_days = 3
  cloudwatch_log_retention_in_days   = 30

  # --- Database Settings ---
  db_instance_class          = "db.t3.micro"
  db_allocated_storage       = 20
  db_storage_type            = "gp2"
  db_engine_version          = "17.4"
  db_backup_retention_period = 7
}
