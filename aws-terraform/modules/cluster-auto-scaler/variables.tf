variable "aws_region" {
  type    = string
  default = "us-east-1"
}

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

variable "cluster-autoscaler-sa" {
  type    = string
  default = "cluster-autoscaler-sa"
}

variable "cluster-autoscaler-ns" {
  type    = string
  default = "cluster-autoscaler"
}

variable "eks-controle-plane-name" {
  type    = string
  default = "2560-dev-del"
}
