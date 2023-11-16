data "aws_route53_zone" "route53_zone" {
  name         = var.domain_name
  private_zone = false
}
