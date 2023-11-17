provider "aws" {
  region = local.aws_region
}

# terraform blocks
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# terraform {
#   backend "s3" {
#     bucket         = "2560-dev-del-backend"
#     dynamodb_table = "2560-dev-del-backend-lock"
#     key            = "aws-terraform/jenkins-master/a1-jenkins/terraform.tfstate"
#     region         = "us-east-1"
#   }
# }

locals {
  aws_region       = "us-east-1"
  enable_user_data = false # set this to true if you want to install jenkins
  use_custom_ami   = true  # set this to true if you have jenkins AMI

  private_subnets = {
    "us-east-1a" = "subnet-096d45c28d9fb4c14"
    "us-east-1b" = "subnet-05f285a35173783b0"
    "us-east-1c" = "subnet-0fe3255479ad7c3a4"
  }

  public_subnets = {
    "us-east-1a" = "subnet-096d45c28d9fb4c14"
    "us-east-1b" = "subnet-05f285a35173783b0"
    "us-east-1c" = "subnet-0fe3255479ad7c3a4"
  }

  vpc_id             = "vpc-068852590ea4b093b"
  image_id           = "ami-08037092db59755a9" # Set this if you have jenkins image
  key_name           = "terraform-aws"
  min_size           = 1
  max_size           = 1
  instance_type      = "t2.medium"
  volume_size        = "50"
  load_balancer_type = "application"
  internal-elb       = false
  domain             = "devopseasylearning.net"
  subdomain_name     = "del-dev-jenkins"
  jenkins-role-name  = "jenkins-master-role"


  common_tags = {
    "Teams"         = "DEL"
    "environment"   = "dev"
    "project"       = "del"
    "createBy"      = "Terraform"
    "cloudProvider" = "aws"
  }
}

module "jenkins-master" {
  source             = "../../modules/jenkins-master"
  aws_region         = local.aws_region
  enable_user_data   = local.enable_user_data
  use_custom_ami     = local.use_custom_ami
  image_id           = local.image_id
  key_name           = local.key_name
  vpc_id             = local.vpc_id
  private_subnets    = local.private_subnets
  public_subnets     = local.public_subnets
  min_size           = local.min_size
  max_size           = local.max_size
  instance_type      = local.instance_type
  volume_size        = local.volume_size
  load_balancer_type = local.load_balancer_type
  internal-elb       = local.internal-elb
  subdomain_name     = local.subdomain_name
  domain             = local.domain
  jenkins-role-name  = local.jenkins-role-name
  common_tags        = local.common_tags
}
