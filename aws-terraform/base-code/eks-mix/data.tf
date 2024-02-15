# Get AWS Account ID
data "aws_caller_identity" "current" {}

data "aws_eks_cluster" "example" {
  depends_on = [
    aws_eks_cluster.eks
  ]
  name = var.control_plane_name
}

data "aws_eks_cluster_auth" "example" {
  depends_on = [
    aws_eks_cluster.eks
  ]
  name = var.control_plane_name
}

# https://stackoverflow.com/questions/64624411/terraform-external-data-source-eks-thumbprint-not-working-sometimes
# openid connect provider is needed for kubernetes service account
data "tls_certificate" "example" {
  url = aws_eks_cluster.eks.identity.0.oidc.0.issuer
}
