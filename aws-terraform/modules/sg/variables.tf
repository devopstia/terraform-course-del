variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
  type        = string
}

variable "sg_name" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(number)
  default = [
    22,
    80,
    8080
  ]
}

variable "tags" {
  description = "Common tags to be applied to resources"
  type        = map(string)
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
