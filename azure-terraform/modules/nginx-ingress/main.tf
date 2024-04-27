resource "helm_release" "external_nginx" {
  name = "external"

  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "nginx-ingress-controller"
  create_namespace = true
  version          = "4.8.0"

  values = [file("${path.module}/values/nginx-ingress-controller.yaml")]
}