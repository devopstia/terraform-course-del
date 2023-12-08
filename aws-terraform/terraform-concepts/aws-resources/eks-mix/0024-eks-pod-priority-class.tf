resource "kubernetes_priority_class" "class-1000000000" {
  metadata {
    name = "critical"
  }
  global_default = false
  value          = 1000000000
  description    = "This should be used for pods which are critical in priority"
  depends_on = [
    aws_eks_cluster.eks
  ]
}

resource "kubernetes_priority_class" "class-900000000" {
  metadata {
    name = "severe"
  }
  global_default = false
  value          = 900000000
  description    = "This should be used for pods which are severe in priority"
  depends_on = [
    aws_eks_cluster.eks
  ]
}

resource "kubernetes_priority_class" "class-800000000" {
  metadata {
    name = "substantial"
  }
  global_default = false
  value          = 800000000
  description    = "This should be used for pods which are substantial in priority"
  depends_on = [
    aws_eks_cluster.eks
  ]
}

resource "kubernetes_priority_class" "class-700000000" {
  metadata {
    name = "moderate"
  }
  global_default = false
  value          = 700000000
  description    = "This should be used for pods which are moderate in priority"
  depends_on = [
    aws_eks_cluster.eks
  ]
}

resource "kubernetes_priority_class" "class-600000000" {
  metadata {
    name = "low"
  }
  global_default = false
  value          = 600000000
  description    = "This should be used for pods which are low in priority"
  depends_on = [
    aws_eks_cluster.eks
  ]
}
