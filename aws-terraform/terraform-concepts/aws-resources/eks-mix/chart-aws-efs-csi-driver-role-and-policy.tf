# variable "aws-efs-csi-driver-sa" {
#   type    = string
#   default = "aws-efs-csi-driver-sa"
# }

# variable "aws-efs-csi-driver-ns" {
#   type    = string
#   default = "aws-efs-csi-driver"
# }

# resource "aws_iam_role" "aws-efs-csi-driver" {
#   name = "${var.control_plane_name}-aws-efs-csi-driver-iam-role"
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
#             join(":", [split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1], "sub"]) : "system:serviceaccount:${var.aws-efs-csi-driver-ns}:${var.aws-efs-csi-driver-sa}"
#           }
#         }
#       },
#     ]
#   })

#   tags = {
#     tag-key = "${data.aws_eks_cluster.example.id}-aws-efs-csi-driver-iam-role"
#   }
# }

# # https://raw.githubusercontent.com/kubernetes-sigs/aws-efs-csi-driver/master/docs/iam-policy-example.json
# resource "aws_iam_policy" "aws-efs-csi-driver-polcy" {
#   name        = "aws-efs-csi-driver-polcy"
#   path        = "/"
#   description = "External DNS IAM Policy"
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

# resource "aws_iam_role_policy_attachment" "aws-efs-csi-driver_attach" {
#   role       = aws_iam_role.aws-efs-csi-driver.name
#   policy_arn = aws_iam_policy.aws-efs-csi-driver-polcy.arn
# }

