variable "tags" {
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

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "external-dns-sa" {
  type    = string
  default = "external-dns-sa"
}

variable "external-dns-ns" {
  type    = string
  default = "external-dns"
}

variable "eks-controle-plane-name" {
  type    = string
  default = "2560-dev-del"
}
