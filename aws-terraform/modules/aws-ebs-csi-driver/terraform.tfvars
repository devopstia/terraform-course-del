
aws_region              = "us-east-1"
aws-ebs-csi-driver-sa   = "aws-ebs-csi-driver-sa"
aws-ebs-csi-driver-ns   = "aws-ebs-csi-driver"
eks-controle-plane-name = "2560-dev-del"
storage-class-name      = "2560-dev-del"
tags = {
  "id"             = "2560"
  "owner"          = "DevOps Easy Learning"
  "teams"          = "DEL"
  "environment"    = "dev"
  "project"        = "del"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}
