variable "aws_region" {
  type = string
}

variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}


## VPC
variable "cidr_block" {
  type = string
}

variable "instance_tenancy" {
  type = string
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "assign_generated_ipv6_cidr_block" {
  type = bool
}

variable "cluster_name" {
  type = string
}

variable "private-subnets-cdir" {
  type = list(any)
}

variable "public-subnet-cidr" {
  type = list(any)
}

variable "aws_availability_zones" {
  type = list(any)
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
  ]
}

variable "shared" {
  type    = string
  default = "shared"
}
