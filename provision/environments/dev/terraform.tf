# --- Versions ---
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.100.0"
    }

    awscc = {
      source  = "hashicorp/awscc"
      version = "1.45.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }

  backend "s3" {
    bucket       = "autumn-awesome-tfstate-dev"
    key          = "global/terraform.tfstate"
    region       = "ap-southeast-1"
    use_lockfile = true
    encrypt      = true
    profile      = var.profile
  }

  required_version = "1.12.1"
}

# --- Providers ---
provider "aws" {
  region  = var.aws_region
  profile = var.profile
}

provider "aws" {
  alias   = "server_function"
  region  = var.aws_region
  profile = var.profile
}

provider "aws" {
  alias   = "iam"
  region  = var.aws_region
  profile = var.profile
}

provider "aws" {
  alias   = "dns"
  region  = var.aws_region
  profile = var.profile
}

provider "aws" {
  alias   = "global"
  region  = "us-east-1"
  profile = var.profile
}

provider "awscc" {
  region  = var.aws_region
  profile = var.profile
}

# --- Data ---
data "aws_route53_zone" "subdomain" {
  name         = local.subdomain
  private_zone = false
}
