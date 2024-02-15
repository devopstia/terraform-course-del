# variable "service_account_name" {
#   type    = string
#   default = "amazon-ebs-csi-driver"
# }

# # Remove https on OpenID Connect provider URL
# # https://oidc.eks.us-east-1.amazonaws.com/id/51C78AC6ADC42A55DE543DFE84A03DE6
# output "identity-oidc-url" {
#   value = split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1]
# }

# output "aws_iam_openid_connect_provider_url" {
#   value = join("/", ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider", split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1]])
# }

# resource "aws_iam_role" "irsa_iam_role" {
#   name = "${var.control_plane_name}-irsa-iam-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRoleWithWebIdentity"
#         Effect = "Allow"
#         Sid    = ""
#         Principal = {
#           Federated = join("/", ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider", split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1]])
#         }
#         Condition = {
#           StringEquals = {
#             join(":", [split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1], "sub"]) : "system:serviceaccount:${var.namespace}:${var.service_account_name}"
#           }
#         }
#       },
#     ]
#   })

#   tags = {
#     tag-key = "${data.aws_eks_cluster.example.id}-irsa-iam-role"
#   }
# }

# # https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/docs/iam-policy-example.json
# resource "aws_iam_policy" "efs-csi-driver-polcy" {
#   name = "eks-efs-csi-driver-polcy"

#   policy = jsonencode(
#     {
#       "Version" : "2012-10-17",
#       "Statement" : [
#         {
#           "Effect" : "Allow",
#           "Action" : [
#             "elasticfilesystem:DescribeAccessPoints",
#             "elasticfilesystem:DescribeFileSystems",
#             "elasticfilesystem:DescribeMountTargets",
#             "ec2:DescribeAvailabilityZones"
#           ],
#           "Resource" : "*"
#         },
#         {
#           "Effect" : "Allow",
#           "Action" : [
#             "elasticfilesystem:CreateAccessPoint"
#           ],
#           "Resource" : "*",
#           "Condition" : {
#             "StringLike" : {
#               "aws:RequestTag/efs.csi.aws.com/cluster" : "true"
#             }
#           }
#         },
#         {
#           "Effect" : "Allow",
#           "Action" : "elasticfilesystem:DeleteAccessPoint",
#           "Resource" : "*",
#           "Condition" : {
#             "StringEquals" : {
#               "aws:ResourceTag/efs.csi.aws.com/cluster" : "true"
#             }
#           }
#         }
#       ]
#     }
#   )
# }

# resource "aws_iam_role_policy_attachment" "policy_attachment" {
#   role       = aws_iam_role.irsa_iam_role.name
#   policy_arn = aws_iam_policy.efs-csi-driver-polcy.arn
# }

