variable "aws_region" {
  type = string
}

variable "aws-readonly-group" {
  type    = string
  default = "aws-readonly-group"
}

variable "aws-eks-admin-group" {
  type    = string
  default = "aws-eks-admin-group"
}

variable "aws-admin-group" {
  type    = string
  default = "aws-admin-group"
}

variable "aws-eks-admin-users" {
  type = set(string)
  default = [
    "awseksadmin1",
    "awseksadmin2",
    "awseksadmin3"
  ]
}

variable "aws-readonly-users" {
  type = set(string)
  default = [
    "readonly1",
    "readonly2",
    "readonly3"
  ]
}

variable "aws-admin-users" {
  type = set(string)
  default = [
    "awsadmin1",
    "awsadmin2",
    "awsadmin3"
  ]
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
