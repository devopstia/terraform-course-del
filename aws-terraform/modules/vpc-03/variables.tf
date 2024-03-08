variable "region" {
  type = string
}

variable "availability_zones" {
  type = list(any)
}

variable "cidr_block" {
  type        = string
  description = "VPC cidr block. Example: 10.0.0.0/16"
}

variable "tags" {
  type        = map(string)
  description = "Common tags to be applied to resources"
  default = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "production"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

variable "cluster_name" {
  type    = string
  default = "2560-dev-del"
}

variable "nat_number" {
  type    = string
  default = "1"
}