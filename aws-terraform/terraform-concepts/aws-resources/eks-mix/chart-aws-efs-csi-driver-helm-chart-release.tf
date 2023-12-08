# # Install EFS CSI Driver using HELM

# # Resource: Helm Release 
# resource "helm_release" "aws-efs-csi-driver" {
#   depends_on = [aws_iam_role.aws-efs-csi-driver]
#   name       = var.aws-efs-csi-driver-ns

#   repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver"
#   chart      = var.aws-efs-csi-driver-ns

#   namespace = var.aws-efs-csi-driver-ns

#   set {
#     name  = "image.repository"
#     value = "602401143452.dkr.ecr.us-east-1.amazonaws.com/eks/aws-efs-csi-driver" # Changes based on Region - This is for us-east-1 Additional Reference: https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html
#   }

#   set {
#     name  = "controller.serviceAccount.create"
#     value = "true"
#   }

#   set {
#     name  = "controller.serviceAccount.name"
#     value = var.aws-efs-csi-driver-sa
#   }

#   set {
#     name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
#     value = aws_iam_role.aws-efs-csi-driver.arn
#   }
# }
