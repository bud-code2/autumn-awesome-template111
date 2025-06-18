#################################################
# VPC Flow Logs Bucket
#################################################
resource "aws_s3_bucket" "vpc_flow_logs" {
  bucket        = "${var.name_prefix}-vpc-flow-logs-bucket"
  force_destroy = var.force_destroy

  tags = {
    Name = "${var.name_prefix}-vpc-flow-logs"
  }
}

resource "aws_s3_bucket_ownership_controls" "vpc_flow_logs" {
  bucket = aws_s3_bucket.vpc_flow_logs.id

  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_versioning" "vpc_flow_logs" {
  bucket = aws_s3_bucket.vpc_flow_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "vpc_flow_logs" {
  depends_on = [aws_s3_bucket_ownership_controls.vpc_flow_logs]

  bucket = aws_s3_bucket.vpc_flow_logs.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_lifecycle_configuration" "vpc_flow_logs" {
  bucket = aws_s3_bucket.vpc_flow_logs.id

  rule {
    id     = "delete_after_${var.log_expiration_days}_days"
    status = "Enabled"

    filter {
      prefix = ""
    }

    expiration {
      days = var.log_expiration_days
    }
  }

  rule {
    id     = "move_to_${var.noncurrent_version_storage_class}"
    status = "Enabled"

    filter {
      prefix = ""
    }

    noncurrent_version_transition {
      noncurrent_days = var.noncurrent_version_transition_days
      storage_class   = var.noncurrent_version_storage_class
    }
  }
}
