variable "tags" {
  type        = map(string)
  description = "Common tags to be applied to resources"
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

variable "region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "eks_version" {
  type = string
}

variable "endpoint_private_access" {
  type = bool
}

variable "endpoint_public_access" {
  type = bool
}

variable "public_subnets" {
  type = map(string)
  default = {
    us-east-1a = "subnet-096d45c28d9fb4c14"
    us-east-1b = "subnet-05f285a35173783b0"
    us-east-1c = "subnet-0fe3255479ad7c3a4"
  }
}
