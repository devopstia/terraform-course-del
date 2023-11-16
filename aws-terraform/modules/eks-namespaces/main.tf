resource "kubernetes_namespace" "k8s_namespace" {
  for_each = toset(var.name_spaces)
  metadata {
    name = each.key
  }
}

