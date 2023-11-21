resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd-${var.env}"
  }
}

provider "kubernetes" {
  config_path = "C:\\Users\\Tia\\.kube\\config"
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://charts.bitnami.com/bitnami" # Bitnami Helm chart repository
  chart      = "argo-cd"                            # Bitnami Argo CD chart name
  namespace  = "argo-cd"
  version    = "2.0.1" # Specify the desired chart version
  values = [
    file("./argocd/install.yaml")
  ]
}

# resource "null_resource" "password" {
#   provisioner "local-exec" {
#     working_dir = "./argocd"
#     command     = "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath={.data.password} | base64 -d > argocd-login.txt"
#   }
# }

# resource "null_resource" "del-argo-pass" {
#   depends_on = [null_resource.password]
#   provisioner "local-exec" {
#     command = "kubectl -n argocd delete secret argocd-initial-admin-secret"
#   }
# }
