aws_region = "us-east-1"
vpc_id     = "vpc-068852590ea4b093b"
sg_name    = "test"

allowed_ports = [
  22,
  80,
  8080
]
tags = {
  "id"             = "2560"
  "owner"          = "DevOps Easy Learning"
  "teams"          = "DEL"
  "environment"    = "dev"
  "project"        = "del"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}
