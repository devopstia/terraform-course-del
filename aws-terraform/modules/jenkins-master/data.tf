data "aws_acm_certificate" "devopseasylearning" {
  domain   = var.domain
  statuses = ["ISSUED"]
}

data "aws_route53_zone" "example_zone" {
  name = var.domain
}
