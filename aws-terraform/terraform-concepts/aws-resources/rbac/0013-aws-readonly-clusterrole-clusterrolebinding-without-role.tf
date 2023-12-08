# https://github.com/uruddarraju/kubernetes-rbac-policies
# kubectl api-resources -o wide
resource "kubernetes_cluster_role_v1" "aws-eks-readonly-clusterrole-without-role" {
  metadata {
    name = "aws-eks-readonly-clusterrole-without-role"
  }
  rule {
    api_groups = [""] # These come under core APIs
    resources  = ["*"]
    verbs      = ["get", "watch", "list"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["*"]
    verbs      = ["get", "watch", "list"]
  }
  rule {
    api_groups = ["autoscaling"]
    resources  = ["*"]
    verbs      = ["get", "watch", "list"]
  }
  rule {
    api_groups = ["batch"]
    resources  = ["*"]
    verbs      = ["get", "watch", "list"]
  }
  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["*"]
    verbs      = ["get", "watch", "list"]
  }
  rule {
    api_groups = ["policy"]
    resources  = ["*"]
    verbs      = ["get", "watch", "list"]
  }
  rule {
    api_groups = ["rbac.authorization.k8s.io"]
    resources  = ["*"]
    verbs      = ["get", "watch", "list"]
  }
  rule {
    api_groups = ["storage.k8s.io"]
    resources  = ["*"]
    verbs      = ["get", "watch", "list"]
  }
}


# Resource: Cluster Role Binding
resource "kubernetes_cluster_role_binding_v1" "aws-eks-readonly-clusterrole-without-role-binding" {
  metadata {
    name = "aws-eks-readonly-clusterrole-without-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.aws-eks-readonly-clusterrole-without-role.metadata.0.name
  }
  subject {
    kind = "Group"
    # this must much with the readonly group name in AWS. 
    # It has to be the same in aws-auth
    name      = aws_iam_group.AWS-ReadOnly-Group.name
    api_group = "rbac.authorization.k8s.io"
  }
}

