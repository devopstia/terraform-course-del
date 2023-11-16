provider "aws" {
  region = local.region
}

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
#     bucket         = ""
#     dynamodb_table = ""
#     key            = ""
#     region         = ""
#   }
# }

locals {
  region             = "us-east-1"
  aws_region         = "us-east-1"
  cluster_name       = "2560-dev-del"
  eks_version        = "1.24"
  control_plane_name = "2560-dev-del"

  ## vpc
  cidr_block = "10.0.0.0/16"
  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]

  ## eks-control-plane
  endpoint_private_access = false
  endpoint_public_access  = true
  public_subnets = {
    us-east-1a = "subnet-096d45c28d9fb4c14"
    us-east-1b = "subnet-05f285a35173783b0"
    us-east-1c = "subnet-0fe3255479ad7c3a4"
  }

  ## eks-blue-green-node-group
  private_subnets = {
    us-east-1a = "subnet-096d45c28d9fb4c14"
    us-east-1b = "subnet-05f285a35173783b0"
    us-east-1c = "subnet-0fe3255479ad7c3a4"
  }

  node_min     = "1"
  desired_node = "1"
  node_max     = "6"

  blue_node_color  = "blue"
  green_node_color = "green"

  blue  = false
  green = true

  ec2_ssh_key               = "terraform"
  deployment_nodegroup      = "blue_green"
  capacity_type             = "ON_DEMAND"
  ami_type                  = "AL2_x86_64"
  instance_types            = "t2.micro"
  disk_size                 = "10"
  shared_owned              = "shared"
  enable_cluster_autoscaler = "true"


  tags = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

module "vpc" {
  source             = "../../modules/vpc"
  cidr_block         = local.cidr_block
  region             = local.region
  availability_zones = local.availability_zones
  cluster_name       = local.cluster_name
  tags               = local.tags
}

module "eks-control-plane" {
  source                  = "../../modules/eks-control-plane"
  region                  = local.region
  cluster_name            = local.cluster_name
  eks_version             = local.eks_version
  endpoint_private_access = local.endpoint_private_access
  endpoint_public_access  = local.endpoint_public_access
  public_subnets          = local.public_subnets
  tags                    = local.tags
}

module "eks-blue-green-node-group" {
  source                    = "../../modules/eks-blue-green-node-group"
  aws_region                = local.aws_region
  control_plane_name        = local.control_plane_name
  eks_version               = local.eks_version
  private_subnets           = local.private_subnets
  node_min                  = local.node_min
  desired_node              = local.desired_node
  node_max                  = local.node_max
  blue_node_color           = local.blue_node_color
  green_node_color          = local.green_node_color
  blue                      = local.blue
  green                     = local.green
  ec2_ssh_key               = local.ec2_ssh_key
  deployment_nodegroup      = local.deployment_nodegroup
  capacity_type             = local.capacity_type
  ami_type                  = local.ami_type
  instance_types            = local.instance_types
  disk_size                 = local.disk_size
  shared_owned              = local.shared_owned
  enable_cluster_autoscaler = local.enable_cluster_autoscaler
  tags                      = local.tags
}

module "aws-auth-config" {
  source             = "../../modules/aws-auth-config"
  aws_region         = local.aws_region
  control_plane_name = local.control_plane_name
}
