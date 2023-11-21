# Resource: Helm Release 
resource "helm_release" "external_dns" {
  depends_on = [aws_iam_role.external-dns]
  name       = var.external-dns-ns
  # https://github.com/bitnami/charts
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"

  namespace = var.external-dns-ns

  set {
    name  = "image.repository"
    value = "bitnami/external-dns"
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = var.external-dns-sa
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.external-dns.arn
  }

  set {
    name  = "provider"
    value = "aws"
  }

  set {
    name  = "policy" # Default is "upsert-only" which means DNS records will not get deleted even equivalent Ingress resources are deleted (https://github.com/kubernetes-sigs/external-dns/tree/master/charts/external-dns)
    value = "sync"   # "sync" will ensure that when ingress resource is deleted, equivalent DNS record in Route53 will get deleted
  }
}
