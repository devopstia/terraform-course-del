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

variable "aws-ebs-csi-driver-sa" {
  type    = string
  default = "aws-ebs-csi-driver-sa"
}

variable "aws-ebs-csi-driver-ns" {
  type    = string
  default = "aws-ebs-csi-driver"
}

variable "eks-controle-plane-name" {
  type    = string
  default = "2560-dev-del"
}

variable "storage-class-name" {
  type    = string
  default = "terraform-storage-class"
}

