# # Install AWS Load Balancer Controller using HELM

# # Resource: Helm Release 
# resource "helm_release" "loadbalancer_controller" {
#   depends_on = [aws_iam_role.aws-load-balancer-controller]
#   name       = "aws-load-balancer-controller"

#   repository = "https://aws.github.io/eks-charts"
#   chart      = "aws-load-balancer-controller"

#   namespace = "kube-system"

#   set {
#     name  = "image.repository"
#     value = "602401143452.dkr.ecr.us-east-1.amazonaws.com/amazon/aws-load-balancer-controller" # Changes based on Region - This is for us-east-1 Additional Reference: https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html
#   }

#   set {
#     name  = "serviceAccount.create"
#     value = "true"
#   }

#   set {
#     name  = "serviceAccount.name"
#     value = var.aws-load-balancer-controller-sa
#   }

#   set {
#     name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#     value = aws_iam_role.aws-load-balancer-controller.arn
#   }

#   set {
#     name  = "vpcId"
#     value = aws_vpc.main.id
#   }

#   set {
#     name  = "region"
#     value = "us-east-1"
#   }

#   set {
#     name  = "clusterName"
#     value = aws_eks_cluster.eks.name
#   }
# }
