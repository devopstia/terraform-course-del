# variable "name_spaces" {
#   type = list(string)
#   default = [
#     "articles",
#     "aws-ebs-csi-driver",
#     "aws-efs-csi-driver",
#     "aws-load-balancer-controller",
#     "cluster-autoscaler",
#     "covid19",
#     "external-dns",
#     "kube2iam",
#     "metrics-server",
#     "istio-system",
#     "istio-ingress",
#   ]
# }

# resource "kubernetes_namespace" "k8s_namespace" {
#   for_each = toset(var.name_spaces)
#   metadata {
#     name = each.key
#   }
# }

