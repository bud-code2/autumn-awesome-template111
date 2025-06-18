# --- Lambda ---
resource "aws_security_group" "lambda" {
  name   = "${var.name_prefix}-lambda-sg"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-lambda-sg"
  }
}

resource "aws_security_group_rule" "egress_https" {
  security_group_id = aws_security_group.lambda.id
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "lambda_to_rds" {
  security_group_id        = aws_security_group.lambda.id
  type                     = "egress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.rds.id
}

resource "aws_security_group_rule" "rds_from_lambda" {
  security_group_id        = aws_security_group.rds.id
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.lambda.id
}

# --- RDS ---
resource "aws_security_group" "rds" {
  name        = "${var.name_prefix}-rds-sg"
  description = "Security group for RDS"
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "rds_egress" {
  security_group_id = aws_security_group.rds.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# --- VPC Endpoints ---
resource "aws_security_group" "vpc_endpoints" {
  name        = "${var.name_prefix}-vpc-endpoint-sgs"
  description = "Security group for VPC endpoints"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name_prefix}-vpc-endpoint-sgs"
  }
}

resource "aws_security_group_rule" "vpc_endpoints_ingress" {
  security_group_id = aws_security_group.vpc_endpoints.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  description       = "Allow HTTPS traffic from VPC"
}

resource "aws_security_group_rule" "vpc_endpoints_egress" {
  security_group_id = aws_security_group.vpc_endpoints.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [var.vpc_cidr]
  description       = "Allow all outbound traffic"
}
