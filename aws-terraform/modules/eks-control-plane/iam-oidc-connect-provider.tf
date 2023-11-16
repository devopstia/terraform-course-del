data "tls_certificate" "example" {
  url = aws_eks_cluster.eks.identity.0.oidc.0.issuer
}
resource "aws_iam_openid_connect_provider" "example" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.example.certificates.0.sha1_fingerprint]
  url             = aws_eks_cluster.eks.identity.0.oidc.0.issuer

  tags = merge(var.tags, {
    "Name" = format("%s-%s-%s-openid-connect-provider", var.tags["id"], var.tags["environment"], var.tags["project"])
    },
  )
}

output "thumbprint_hash" {
  value = data.tls_certificate.example.certificates.0.sha1_fingerprint
}
