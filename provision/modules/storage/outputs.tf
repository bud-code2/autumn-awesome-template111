output "s3_bucket_vpc_flow_logs" {
  value = {
    name = aws_s3_bucket.vpc_flow_logs.bucket
    arn  = aws_s3_bucket.vpc_flow_logs.arn
  }
}
