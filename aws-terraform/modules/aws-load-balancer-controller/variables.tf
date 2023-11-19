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

variable "aws-load-balancer-controller-sa" {
  type    = string
  default = "aws-load-balancer-controller-sa"
}

variable "aws-load-balancer-controller-ns" {
  type    = string
  default = "kube-system"
}

variable "eks-controle-plane-name" {
  type    = string
  default = "2560-dev-del"
}

variable "vpc_id" {
  type    = string
  default = "vpc-068852590ea4b093b"
}
