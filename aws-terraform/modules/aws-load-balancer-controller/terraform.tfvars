aws_region                      = "us-east-1"
aws-load-balancer-controller-sa = "aws-load-balancer-controller-sa"
aws-load-balancer-controller-ns = "kube-system"
eks-controle-plane-name         = "2560-dev-del"
vpc_id                          = "vpc-068852590ea4b093b"
tags = {
  "id"             = "2560"
  "owner"          = "DevOps Easy Learning"
  "teams"          = "DEL"
  "environment"    = "dev"
  "project"        = "del"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}
