# https://stackoverflow.com/questions/64624411/terraform-external-data-source-eks-thumbprint-not-working-sometimes
# openid connect provider is needed for kubernetes service account
data "tls_certificate" "example" {
  url = aws_eks_cluster.eks.identity.0.oidc.0.issuer
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
resource "aws_iam_openid_connect_provider" "example" {
  client_id_list = ["sts.amazonaws.com"]

  # This is to get the cluster root certificate from aws
  thumbprint_list = [data.tls_certificate.example.certificates.0.sha1_fingerprint]
  # this is to get the openID connect URL from EKS
  url = aws_eks_cluster.eks.identity.0.oidc.0.issuer

  tags = merge(var.common_tags, {
    "Name" = "EKS iam openid connect provider"
    },
  )
}

# this is to print the cluster root certificate
output "thumbprint_hash" {
  value = data.tls_certificate.example.certificates.0.sha1_fingerprint
}
