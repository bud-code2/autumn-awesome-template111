#################################################
# VPC
#################################################
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

resource "aws_flow_log" "main" {
  log_destination      = var.vpc_flow_logs_bucket_arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id
  tags = {
    Name = "${var.name_prefix}-vpc-flow-logs"
  }
}

#################################################
# Internet Gateway
#################################################
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

#################################################
# Subnets
#################################################
# --- Public Subnets ---
resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = "${var.name_prefix}-public-subnet-${each.key}"
  }
}

# --- Private Subnets ---
resource "aws_subnet" "private" {
  for_each          = var.private_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = "${var.name_prefix}-private-subnet-${each.key}"
  }
}

#################################################
# NAT Gateway
#################################################
# --- Elastic IP for NAT Gateway ---
resource "aws_eip" "nat" {
  for_each = toset(var.nat_placement_az_list)

  domain = "vpc"

  tags = {
    Name = "${var.name_prefix}-nat-eip-${each.key}"
  }
}

resource "aws_nat_gateway" "main" {
  for_each = toset(var.nat_placement_az_list)

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[each.key].id
  depends_on    = [aws_internet_gateway.main]

  tags = {
    Name = "${var.name_prefix}-nat-gateway-${each.key}"
  }
}

#################################################
# Route Tables
#################################################
# --- Public Route Table ---
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name_prefix}-public-route-table"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# --- Private Route Table ---
resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name_prefix}-private-route-table"
  }
}

resource "aws_route" "private" {
  for_each = aws_nat_gateway.main

  route_table_id         = aws_route_table.private[each.key].id
  nat_gateway_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}

#################################################
# VPC Endpoint
#################################################
# --- VPC Endpoint for S3 ---
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = [for rt in aws_route_table.private : rt.id]

  tags = {
    Name = "${var.name_prefix}-s3-vpc-endpoint"
  }
}

# --- VPC Endpoint for SSM ---
resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.ssm"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [for subnet in aws_subnet.private : subnet.id]
  security_group_ids  = var.vpc_endpoint_sg_ids

  tags = {
    Name = "${var.name_prefix}-ssm-endpoint"
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [for subnet in aws_subnet.private : subnet.id]
  security_group_ids  = var.vpc_endpoint_sg_ids

  tags = {
    Name = "${var.name_prefix}-ec2messages-endpoint"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  subnet_ids          = [for subnet in aws_subnet.private : subnet.id]
  security_group_ids  = var.vpc_endpoint_sg_ids

  tags = {
    Name = "${var.name_prefix}-ssmmessages-endpoint"
  }
}
