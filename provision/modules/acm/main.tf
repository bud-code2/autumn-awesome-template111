resource "aws_acm_certificate" "subdomain" {
  provider          = aws.global
  domain_name       = var.subdomain
  validation_method = "DNS"

  tags = {
    Name = "${var.name_prefix}-subdomain-certificate"
  }
}

resource "aws_route53_record" "subdomain_cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.subdomain.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id         = var.route53_zone_id
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = 60
  allow_overwrite = true
}
