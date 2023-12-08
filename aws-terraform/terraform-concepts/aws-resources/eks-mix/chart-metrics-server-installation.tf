# resource "helm_release" "metrics-server" {
#   name = "metrics-server"

#   repository = "https://kubernetes-sigs.github.io/metrics-server/"
#   chart      = "metrics-server"
#   namespace  = "metrics-server"
#   version    = "3.8.2"

#   set {
#     name  = "metrics.enabled"
#     value = false
#   }
# }
