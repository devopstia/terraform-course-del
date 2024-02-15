# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster

data "aws_partition" "current" {

}

resource "aws_iam_openid_connect_provider" "example" {
  client_id_list = ["sts.amazonaws.com"]
  # client_id_list = ["sts.${data.aws_partition.current.dns_suffix}"]

  # This is to get the cluster root certificate from aws
  thumbprint_list = [data.tls_certificate.example.certificates.0.sha1_fingerprint]
  # this is to get the openID connect URL from EKS
  url = aws_eks_cluster.eks.identity.0.oidc.0.issuer

  tags = {
    "key" = "EKS iam openid connect provider"
  }
}

# this is to print the cluster root certificate
output "thumbprint_hash" {
  value = data.tls_certificate.example.certificates.0.sha1_fingerprint
}

