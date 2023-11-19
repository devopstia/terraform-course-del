
# kubectl api-resources -o wide

resource "kubernetes_cluster_role_v1" "aws-eks-readonly-clusterrole-with-role" {
  metadata {
    name = "aws-eks-readonly-clusterrole-with-role"
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
    api_groups = ["batch"]
    resources  = ["*"]
    verbs      = ["get", "watch", "list"]
  }
}


# Resource: Cluster Role Binding
resource "kubernetes_cluster_role_binding_v1" "aws-eks-readonly-clusterrole-with-role-binding" {
  metadata {
    name = "aws-eks-readonly-clusterrole-with-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role_v1.aws-eks-readonly-clusterrole-with-role.metadata.0.name
  }
  subject {
    kind = "Group"
    # this must much with the readonly group name in AWS. 
    # It has to be the same in aws-auth
    name      = aws_iam_group.ADFS-AWS-ReadOnly.name
    api_group = "rbac.authorization.k8s.io"
  }
}

