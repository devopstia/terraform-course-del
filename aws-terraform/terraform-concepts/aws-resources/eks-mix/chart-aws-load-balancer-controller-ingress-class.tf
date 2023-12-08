# # Resource: Kubernetes Ingress Class
# resource "kubernetes_ingress_class_v1" "ingress_class_default" {
#   depends_on = [helm_release.loadbalancer_controller]
#   metadata {
#     name = "alb-ingress-class"
#     annotations = {
#       "ingressclass.kubernetes.io/is-default-class" = "true"
#     }
#   }
#   spec {
#     controller = "ingress.k8s.aws/alb"
#   }
# }
