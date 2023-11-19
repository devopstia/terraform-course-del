data "aws_eks_cluster" "example" {
  name = var.eks-controle-plane-name
}

data "aws_eks_cluster_auth" "example" {
  name = var.eks-controle-plane-name
}

# Get AWS Account ID
data "aws_caller_identity" "current" {}
