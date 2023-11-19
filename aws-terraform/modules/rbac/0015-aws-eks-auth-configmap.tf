
locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    # PS pull all the node groups role arn here. We have just one node group in this case
    - rolearn: arn:aws:iam::788210522308:role/2560-dev-alpha-blue-green-node-group-role
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
    - rolearn: ${aws_iam_role.ReadOnly-Role.arn}
      username: ${aws_iam_group.ADFS-AWS-ReadOnly.name}
      groups:
        - ${aws_iam_group.ADFS-AWS-ReadOnly.name}
    - rolearn: ${aws_iam_role.AWS-Admin-Role.arn}
      username: ${aws_iam_group.ADFS-AWS-Admins.name}
      groups:
        - ${aws_iam_group.ADFS-AWS-Admins.name}
        - system:masters
        - cluster-admin
    - rolearn: ${aws_iam_role.AWS-EKS-Admin-Role.arn}
      username: ${aws_iam_group.ADFS-EKS-Admins.name}
      groups:
        - ${aws_iam_group.ADFS-EKS-Admins.name}
        - system:masters
        - cluster-admin
  mapUsers: |
    - userarn: ${aws_iam_user.awsadmin.arn}
      username: ${aws_iam_user.awsadmin.name}
      groups:
        - cluster-admin
        - system:masters
    - userarn: ${aws_iam_user.awseksadmin.arn}
      username: ${aws_iam_user.awseksadmin.name}
      groups:
        - system:masters
        - cluster-admin
    - userarn: ${aws_iam_user.awsreadonly.arn}
      username: ${aws_iam_user.awsreadonly.name}
      groups:
        - "${aws_iam_group.AWS-ReadOnly-Group.name}
CONFIGMAPAWSAUTH
}

# Generate Node Auth File
resource "local_file" "cluster-auth" {
  depends_on = [
    aws_iam_user.awsadmin,
    aws_iam_user.awseksadmin,
    aws_iam_user.awseksadmin,
    aws_iam_user.aws-admin-user-1,
    aws_iam_user.aws-admin-user-2,
    aws_iam_user.aws-admin-user-3,
    aws_iam_user.aws-eks-admin-user-1,
    aws_iam_user.aws-eks-admin-user-2,
    aws_iam_user.aws-eks-admin-user-3,
    aws_iam_user.aws-readony-user-1,
    aws_iam_user.aws-readony-user-2,
    aws_iam_user.aws-readony-user-3,
  ]
  content  = local.config_map_aws_auth
  filename = "aws-auth-configmap.yaml"
}

resource "null_resource" "cluster-auth-configmap-apply" {
  triggers = {
    always_run = timestamp()
  }
  depends_on = [local_file.cluster-auth]
  provisioner "local-exec" {
    command = "kubectl delete cm aws-auth -n kube-system && kubectl apply -f aws-auth-configmap.yaml -n kube-system"
  }
}

