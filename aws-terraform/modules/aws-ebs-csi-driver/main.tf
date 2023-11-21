# Install EBS CSI Driver using HELM
# Resource: Helm Release 
resource "helm_release" "ebs_csi_driver" {
  depends_on = [aws_iam_role.aws-ebs-csi-driver]
  name       = var.aws-ebs-csi-driver-ns
  # https://github.com/kubernetes-sigs/aws-ebs-csi-driver
  # repository = "aws-ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"

  namespace = var.aws-ebs-csi-driver-ns

  # set {
  #   name  = "image.repository"
  #   value = "602401143452.dkr.ecr.us-east-1.amazonaws.com/eks/aws-ebs-csi-driver" # Changes based on Region - This is for us-east-1 Additional Reference: https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html
  # }

  set {
    name  = "controller.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "controller.serviceAccount.name"
    value = var.aws-ebs-csi-driver-sa
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws-ebs-csi-driver.arn
  }
  set {
    name  = "fullnameOverride"
    value = "aws-ebs-csi-driver"
  }
}
