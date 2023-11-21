# Install Cluster Autoscaler using HELM

# Resource: Helm Release 
resource "helm_release" "cluster_autoscaler_release" {
  depends_on = [aws_iam_role.cluster-autoscaler]
  name       = var.cluster-autoscaler-ns
  # https://github.com/kubernetes/autoscaler
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"

  namespace = var.cluster-autoscaler-ns

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = data.aws_eks_cluster.example.name
  }

  set {
    name  = "awsRegion"
    value = var.aws_region
  }

  set {
    name  = "rbac.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = var.cluster-autoscaler-sa
  }

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.cluster-autoscaler.arn
  }
  set {
    name  = "extraArgs.scale-down-delay-after-add"
    value = "2m"
  }
  set {
    name  = "extraArgs.scale-down-unneeded-time"
    value = "2m"
  }
  set {
    name  = "fullnameOverride"
    value = "cluster-autoscaler"
  }
}
