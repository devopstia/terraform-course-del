provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = "> 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}


terraform {
  backend "s3" {
    bucket         = "2560-dev-alpha-s3-backend"
    key            = "eks/blue-green-nodde/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "2560-dev-alpha-s3-dynamodb-table"
  }
}

locals {
  aws_region = "us-east-1"

  common_tags = {
    "AssetID"       = "2560"
    "Environment"   = "dev"
    "Project"       = "alpha"
    "CreateBy"      = "Terraform"
    "cloudProvider" = "aws"
  }

  eks_version  = "1.22"
  node_min     = "1"
  desired_node = "1"
  node_max     = "6"

  blue_node_color  = "blue"
  green_node_color = "green"

  blue  = true
  green = false

  ec2_ssh_key               = "terraform"
  deployment_nodegroup      = "blue_green"
  capacity_type             = "ON_DEMAND"
  ami_type                  = "AL2_x86_64"
  instance_types            = "t2.medium"
  disk_size                 = "10"
  shared_owned              = "shared"
  enable_cluster_autoscaler = "true"
}

module "eks-control-plane" {
  source       = "../../modules/eks-blue-green-node-group"
  eks_version  = local.eks_version
  node_min     = local.node_min
  desired_node = local.desired_node
  node_max     = local.node_max

  blue_node_color  = local.blue_node_color
  green_node_color = local.green_node_color

  blue  = local.blue
  green = local.green

  ec2_ssh_key               = local.ec2_ssh_key
  deployment_nodegroup      = local.deployment_nodegroup
  capacity_type             = local.capacity_type
  ami_type                  = local.ami_type
  instance_types            = local.instance_types
  disk_size                 = local.disk_size
  shared_owned              = local.shared_owned
  enable_cluster_autoscaler = local.enable_cluster_autoscaler
  common_tags               = local.common_tags
}
