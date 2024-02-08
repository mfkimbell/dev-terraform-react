provider "aws" {
  alias  = "aws_useast1"
  region = "us-east-1"
}

data "aws_route53_zone" "my_domain" {
  name         = "mitch-api.com"
  private_zone = false
}

resource "aws_route53_record" "custom_domain_record" {
  name = "api" # The subdomain (api.mitch-api.com)
  type = "CNAME"
  ttl  = "300" # TTL in seconds

  records = ["${aws_api_gateway_rest_api.my_api.id}.execute-api.eu-central-1.amazonaws.com"]

  zone_id = data.aws_route53_zone.my_domain.zone_id
}

resource "aws_acm_certificate" "my_api_cert" {
  domain_name               = "api.mitch-api.com"
  provider                  = aws.aws_useast1       # needs to be in US East 1 region
  subject_alternative_names = ["api.mitch-api.com"] # Your custom domain
  validation_method         = "DNS"
}
