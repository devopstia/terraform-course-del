# data "aws_route53_zone" "route53_zone" {
#   name = var.domain_name
#   # This can be true or false
#   private_zone = false
# }


# variable "aws_region" {
#   type    = string
#   default = "us-east-1"
# }

# variable "domain_name" {
#   type    = string
#   default = "devopseasylearning.net"
# }

# variable "subject_alternative_names" {
#   type    = string
#   default = "*.devopseasylearning.net"
# }

# variable "common_tags" {
#   type = map(any)
#   default = {
#     "AssetID"       = "2560"
#     "AssetName"     = "Insfrastructure"
#     "AssetAreaName" = "ADL"
#     "ControlledBy"  = "Terraform"
#     "cloudProvider" = "aws"
#   }
# }

# module "acm" {
#   source                    = "./modules/acm"
#   aws_region                = var.aws_region
#   domain_name               = var.domain_name
#   subject_alternative_names = var.subject_alternative_names
#   common_tags               = var.common_tags
# }



# resource "aws_route53_record" "cluster-alias" {
#   zone_id = "Z09063052B43KCQ7FSGHY"
#   name    = "dev"
#   type    = "CNAME"
#   ttl     = "30"
#   records = ["ssl-ingress-1837523060.us-east-1.elb.amazonaws.com"]
# }
