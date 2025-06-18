resource "aws_db_instance" "postgres" {
  identifier                      = "${var.name_prefix}-db-instance"
  engine                          = "postgres"
  engine_version                  = var.engine_version
  instance_class                  = var.instance_class
  allocated_storage               = var.allocated_storage
  storage_type                    = var.storage_type
  db_name                         = var.db_name
  username                        = var.db_username
  password                        = var.db_password
  skip_final_snapshot             = true
  publicly_accessible             = false
  deletion_protection             = false
  vpc_security_group_ids          = var.security_group_ids
  db_subnet_group_name            = aws_db_subnet_group.postgres.name
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  tags = {
    Name = "${var.name_prefix}-db-instance"
  }
}

resource "aws_db_subnet_group" "postgres" {
  name       = "${var.name_prefix}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.name_prefix}-db-subnet-group"
  }

}

resource "aws_cloudwatch_log_group" "rds_postgres" {
  name              = "/aws/rds/${var.name_prefix}-db-instance"
  retention_in_days = var.cloudwatch_log_retention_in_days

  tags = {
    Name = "${var.name_prefix}-db-logs"
  }
}

resource "aws_iam_role" "rds_cloudwatch" {
  name = "${var.name_prefix}-rds-cloudwatch-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "rds.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "rds_cloudwatch" {
  name = "${var.name_prefix}-rds-cloudwatch-policy"
  role = aws_iam_role.rds_cloudwatch.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = [
          aws_cloudwatch_log_group.rds_postgres.arn,
          "${aws_cloudwatch_log_group.rds_postgres.arn}:*"
        ]
      }
    ]
  })
}
