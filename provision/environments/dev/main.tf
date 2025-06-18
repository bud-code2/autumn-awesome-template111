module "acm" {
  source = "../../modules/acm"

  name_prefix     = local.name_prefix
  subdomain       = local.subdomain
  route53_zone_id = data.aws_route53_zone.subdomain.zone_id
  providers = {
    aws.global = aws.global
  }
}

module "network" {
  source = "../../modules/network"

  name_prefix              = local.name_prefix
  region                   = var.aws_region
  vpc_cidr                 = local.vpc_cidr
  public_subnets           = local.public_subnets
  private_subnets          = local.private_subnets
  vpc_endpoint_sg_ids      = [module.security_group.sg_ids.vpc_endpoints]
  nat_placement_az_list    = local.nat_placement_az_list
  vpc_flow_logs_bucket_arn = module.storage.s3_bucket_vpc_flow_logs.arn
}

module "security_group" {
  source = "../../modules/security_group"

  name_prefix = local.name_prefix
  vpc_id      = module.network.vpc_id
  vpc_cidr    = local.vpc_cidr
}

module "storage" {
  source = "../../modules/storage"

  name_prefix                        = local.name_prefix
  force_destroy                      = local.force_destroy
  log_expiration_days                = local.log_expiration_days
  noncurrent_version_transition_days = local.noncurrent_version_transition_days
  noncurrent_version_storage_class   = local.noncurrent_version_storage_class
}


module "open-next" {
  source  = "RJPearson94/open-next/aws//modules/tf-aws-open-next-zone"
  version = "3.6.0"

  folder_path       = abspath("${path.root}/../../../webapp/.open-next")
  open_next_version = "v3.x.x"

  prefix = local.name_prefix

  providers = {
    aws.server_function = aws.server_function
    aws.iam             = aws.iam
    aws.dns             = aws.dns
    aws.global          = aws.global
  }

  domain_config = {
    create_route53_entries         = true
    route53_record_allow_overwrite = true
    hosted_zones                   = [{ name = local.subdomain }]
    viewer_certificate = {
      acm_certificate_arn = module.acm.subdomain_certificate_arn
    }
  }

  website_bucket = {
    force_destroy = local.force_destroy
  }


  content_types = {
    mapping = {
      svg = "image/svg+xml"
      js  = "application/javascript",
      mjs = "application/javascript",
      css = "text/css"
    }
  }

  behaviours = {
    allowed_methods = ["*"]
    cached_methods  = ["GET", "HEAD"]
    forward_headers = {
      headers      = ["host", "x-forwarded-for", "x-forwarded-port", "x-forwarded-proto"]
      query_string = true
    }
  }

  scripts = {
    interpreter = var.opennext_shell
    additional_environment_variables = {
      AWS_PROFILE = var.profile
    }
  }

  server_function = {
    backend_deployment_type = "REGIONAL_LAMBDA"
    vpc = {
      security_group_ids = [module.security_group.sg_ids.lambda]
      subnet_ids         = module.network.private_subnet_ids
    }

    additional_iam_policies = []

    additional_environment_variables = {
      "DB_HOST"     = module.database.db_endpoint
      "DB_PORT"     = var.db_port
      "DB_NAME"     = var.db_name
      "DB_USERNAME" = var.db_username
      "DB_PASSWORD" = var.db_password
      "DB_SCHEMA"   = var.db_schema
    }
  }

  waf = {
    deployment = "NONE"
  }

  cloudwatch_log = {
    retention_in_days = local.cloudwatch_log_retention_in_days
  }
}

module "database" {
  source = "../../modules/database"

  name_prefix                      = local.name_prefix
  security_group_ids               = [module.security_group.sg_ids.rds]
  subnet_ids                       = module.network.private_subnet_ids
  instance_class                   = local.db_instance_class
  allocated_storage                = local.db_allocated_storage
  storage_type                     = local.db_storage_type
  engine_version                   = local.db_engine_version
  db_username                      = var.db_username
  db_password                      = var.db_password
  db_name                          = var.db_name
  backup_retention_period          = local.db_backup_retention_period
  enabled_cloudwatch_logs_exports  = ["postgresql"]
  cloudwatch_log_retention_in_days = local.cloudwatch_log_retention_in_days
}
