# # - When EKS Cluster is created, kubernetes object `aws-auth` configmap will not get created
# # - `aws-auth` configmap will be created when the first EKS Node Group gets created to update the EKS Nodes related role information in `aws-auth` configmap. 
# # -  That said, we will populate the equivalent `aws-auth` configmap before creating the EKS Node Group and also we will create EKS Node Group only after configMap `aws-auth` resource is created.

# output "account_id" {
#   value = data.aws_caller_identity.current.account_id
# }

# # Locals Block
# locals {
#   # mapRoles
#   configmap_roles = [
#     {
#       rolearn  = "${aws_iam_role.nodes.arn}"
#       username = "system:node:{{EC2PrivateDNSName}}"
#       groups = [
#         "system:bootstrappers",
#         "system:nodes"
#       ]
#     },
#     {
#       rolearn = "${aws_iam_role.ReadOnly-Role.arn}"
#       # This must match the name that we have in cluster role binding
#       username = "${aws_iam_group.ADFS-AWS-ReadOnly.name}"
#       # username = "ADFS-AWS-ReadOnly"
#       groups = [
#         "${aws_iam_group.ADFS-AWS-ReadOnly.name}",
#       ]
#     },
#     {
#       rolearn  = "${aws_iam_role.AWS-Admin-Role.arn}"
#       username = "${aws_iam_group.ADFS-AWS-Admins.name}" #You can put any name here
#       groups = [
#         "${aws_iam_group.ADFS-AWS-Admins.name}",
#         "system:masters",
#         "cluster-admin"
#       ]
#     },
#     {
#       rolearn  = "${aws_iam_role.AWS-EKS-Admin-Role.arn}"
#       username = "${aws_iam_group.ADFS-EKS-Admins.name}" #You can put any name here
#       groups = [
#         "${aws_iam_group.ADFS-EKS-Admins.name}",
#         "system:masters",
#         "cluster-admin"
#       ]
#     },
#   ]
#   # mapUsers
#   configmap_users = [
#     {
#       userarn  = "${aws_iam_user.awsadmin.arn}"
#       username = "${aws_iam_user.awsadmin.name}"
#       groups = [
#         "system:masters",
#         "cluster-admin"
#       ]
#     },
#     {
#       userarn  = "${aws_iam_user.awseksadmin.arn}"
#       username = "${aws_iam_user.awseksadmin.name}"
#       groups = [
#         "system:masters",
#         "cluster-admin"
#       ]
#     },
#     {
#       userarn  = "${aws_iam_user.awsreadonly.arn}"
#       username = "${aws_iam_user.awsreadonly.name}"
#       groups = [
#         "${aws_iam_group.AWS-ReadOnly-Group.name}",
#       ]
#     },
#   ]
# }
# resource "kubernetes_config_map_v1" "aws_auth" {
#   depends_on = [
#     aws_iam_user.awsadmin,
#     aws_iam_user.awseksadmin,
#     aws_iam_user.awseksadmin,
#     aws_iam_user.aws-admin-user-1,
#     aws_iam_user.aws-admin-user-2,
#     aws_iam_user.aws-admin-user-3,
#     aws_iam_user.aws-eks-admin-user-1,
#     aws_iam_user.aws-eks-admin-user-2,
#     aws_iam_user.aws-eks-admin-user-3,
#     aws_iam_user.aws-readony-user-1,
#     aws_iam_user.aws-readony-user-2,
#     aws_iam_user.aws-readony-user-3,
#   ]
#   metadata {
#     name      = "aws-auth"
#     namespace = "kube-system"
#   }

#   data = {
#     mapRoles = yamlencode(local.configmap_roles)
#     mapUsers = yamlencode(local.configmap_users)
#   }
# }
