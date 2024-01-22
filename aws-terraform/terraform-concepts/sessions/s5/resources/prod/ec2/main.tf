terraform {
  required_version = "~> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = local.aws_region
}

terraform {
  backend "s3" {
    bucket         = "2560-production-s5-tf-state"
    key            = "aws-terraform/ec2/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "2560-production-s5-tf-state-lock"
  }
}

locals {
  aws_region    = "us-west-1"
  instance_name = "web"
  instance_params = {
    instance_type          = "t2.micro"
    key_name               = "s5prokey"
    vpc_security_group_ids = "sg-0edc6af1f8ab22f01"
    subnet_id              = "subnet-06bcfa3ec3ba624d4"
    volume_size            = "20"
  }

  tags = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "production"
    "project"        = "alpha"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

module "ec2" {
  source          = "../../../modules/ec2"
  aws_region      = local.aws_region
  instance_params = local.instance_params
  instance_name   = local.instance_name
  tags            = local.tags
}