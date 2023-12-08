provider "aws" {
  region = var.aws_region
}

# terraform blocks
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

terraform {
  backend "remote" {
    organization = "S4-ORG"
    workspaces {
      name = "postgres"
    }
  }
}


locals {
  postgres = {
    engine                      = "postgres"
    engine_version              = "13.4"
    instance_class              = "db.t3.small"
    allocated_storage           = 20
    max_allocated_storage       = 100
    publicly_accessible         = false
    name                        = "artifactory"
    final_snapshot_identifier   = "alpha-db-snapshot"
    skip_final_snapshot         = false
    backup_retention_period     = 7
    deletion_protection         = true
    maintenance_window          = "Sun:03:00-Sun:04:00"
    multi_az                    = false
    allow_major_version_upgrade = false
    auto_minor_version_upgrade  = true
    family                      = "postgres13"
    zone_id                     = "Z09063052B43KCQ7FSGHY"
    aws_route53_record          = "artifactory"
  }

  common_tags = {
    "AssetID"       = "2560"
    "AssetName"     = "Insfrastructure"
    "Teams"         = "DEL"
    "Environment"   = "dev"
    "Project"       = "alpha"
    "CreateBy"      = "Terraform"
    "cloudProvider" = "aws"
  }
}

module "vpc" {
  source                = "./postgres"
  aws_region            = var.aws_region
  AWS_ACCESS_KEY_ID     = var.AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
  postgres              = local.postgres
  db_password           = var.db_password
  db_username           = var.db_username
  common_tags           = local.common_tags
}
