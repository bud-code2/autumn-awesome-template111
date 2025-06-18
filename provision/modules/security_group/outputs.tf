output "sg_ids" {
  value = {
    lambda        = aws_security_group.lambda.id
    rds           = aws_security_group.rds.id
    vpc_endpoints = aws_security_group.vpc_endpoints.id
  }
}
