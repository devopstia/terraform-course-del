
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = lookup(local.aws_instance, "region", "null")
}

# locals {
#   aws_instance = lookup(yamldecode(file("./variable.yaml"))["dev"], "aws_instance", {})
#   common_tags  = lookup(yamldecode(file("./variable.yaml"))["dev"]["aws_instance"], "tags", {})
# }

locals {
  aws_instance = lookup(yamldecode(file("${path.module}/variable.yaml"))["dev"], "aws_instance", {})
  common_tags  = lookup(yamldecode(file("${path.module}/variable.yaml"))["dev"]["aws_instance"], "tags", {})
}

output "name1" {
  value = local.common_tags
}
output "name2" {
  value = local.aws_instance
}
module "ec2-instance" {
  source        = "terraform-aws-modules/ec2-instance/aws"
  version       = "4.3.0"
  ami           = lookup(local.aws_instance, "ami", "null")
  instance_type = lookup(local.aws_instance, "instance_type", "t2.small")
  tags = {
    Name        = format("%s-%s-web", lookup(local.common_tags, "environment", "null"), lookup(local.common_tags, "project", "null"))
    project     = lookup(local.common_tags, "project", "null")
    environment = lookup(local.common_tags, "environment", "null")
    Create_by   = lookup(local.common_tags, "terraform", "Terraform")
  }
}


