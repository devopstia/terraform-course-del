# variable "aws-ebs-csi-driver-sa" {
#   type    = string
#   default = "aws-ebs-csi-driver-sa"
# }

# variable "aws-ebs-csi-driver-ns" {
#   type    = string
#   default = "aws-ebs-csi-driver"
# }

# resource "aws_iam_role" "aws-ebs-csi-driver" {
#   name = "${var.control_plane_name}-aws-ebs-csi-driver-iam-role"
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
#             join(":", [split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1], "sub"]) : "system:serviceaccount:${var.aws-ebs-csi-driver-ns}:${var.aws-ebs-csi-driver-sa}"
#           }
#         }
#       },
#     ]
#   })

#   tags = {
#     tag-key = "${data.aws_eks_cluster.example.id}-aws-ebs-csi-driver-iam-role"
#   }
# }

# # https://raw.githubusercontent.com/kubernetes-sigs/aws-ebs-csi-driver/master/docs/example-iam-policy.json
# resource "aws_iam_policy" "aws-ebs-csi-driver-polcy" {
#   name        = "aws-ebs-csi-driver-polcy"
#   path        = "/"
#   description = "External DNS IAM Policy"
#   policy = jsonencode(
#     {
#       "Version" : "2012-10-17",
#       "Statement" : [
#         {
#           "Effect" : "Allow",
#           "Action" : [
#             "ec2:CreateSnapshot",
#             "ec2:AttachVolume",
#             "ec2:DetachVolume",
#             "ec2:ModifyVolume",
#             "ec2:DescribeAvailabilityZones",
#             "ec2:DescribeInstances",
#             "ec2:DescribeSnapshots",
#             "ec2:DescribeTags",
#             "ec2:DescribeVolumes",
#             "ec2:DescribeVolumesModifications"
#           ],
#           "Resource" : "*"
#         },
#         {
#           "Effect" : "Allow",
#           "Action" : [
#             "ec2:CreateTags"
#           ],
#           "Resource" : [
#             "arn:aws:ec2:*:*:volume/*",
#             "arn:aws:ec2:*:*:snapshot/*"
#           ],
#           "Condition" : {
#             "StringEquals" : {
#               "ec2:CreateAction" : [
#                 "CreateVolume",
#                 "CreateSnapshot"
#               ]
#             }
#           }
#         },
#         {
#           "Effect" : "Allow",
#           "Action" : [
#             "ec2:DeleteTags"
#           ],
#           "Resource" : [
#             "arn:aws:ec2:*:*:volume/*",
#             "arn:aws:ec2:*:*:snapshot/*"
#           ]
#         },
#         {
#           "Effect" : "Allow",
#           "Action" : [
#             "ec2:CreateVolume"
#           ],
#           "Resource" : "*",
#           "Condition" : {
#             "StringLike" : {
#               "aws:RequestTag/ebs.csi.aws.com/cluster" : "true"
#             }
#           }
#         },
#         {
#           "Effect" : "Allow",
#           "Action" : [
#             "ec2:CreateVolume"
#           ],
#           "Resource" : "*",
#           "Condition" : {
#             "StringLike" : {
#               "aws:RequestTag/CSIVolumeName" : "*"
#             }
#           }
#         },
#         {
#           "Effect" : "Allow",
#           "Action" : [
#             "ec2:DeleteVolume"
#           ],
#           "Resource" : "*",
#           "Condition" : {
#             "StringLike" : {
#               "ec2:ResourceTag/ebs.csi.aws.com/cluster" : "true"
#             }
#           }
#         },
#         {
#           "Effect" : "Allow",
#           "Action" : [
#             "ec2:DeleteVolume"
#           ],
#           "Resource" : "*",
#           "Condition" : {
#             "StringLike" : {
#               "ec2:ResourceTag/CSIVolumeName" : "*"
#             }
#           }
#         },
#         {
#           "Effect" : "Allow",
#           "Action" : [
#             "ec2:DeleteVolume"
#           ],
#           "Resource" : "*",
#           "Condition" : {
#             "StringLike" : {
#               "ec2:ResourceTag/kubernetes.io/created-for/pvc/name" : "*"
#             }
#           }
#         },
#         {
#           "Effect" : "Allow",
#           "Action" : [
#             "ec2:DeleteSnapshot"
#           ],
#           "Resource" : "*",
#           "Condition" : {
#             "StringLike" : {
#               "ec2:ResourceTag/CSIVolumeSnapshotName" : "*"
#             }
#           }
#         },
#         {
#           "Effect" : "Allow",
#           "Action" : [
#             "ec2:DeleteSnapshot"
#           ],
#           "Resource" : "*",
#           "Condition" : {
#             "StringLike" : {
#               "ec2:ResourceTag/ebs.csi.aws.com/cluster" : "true"
#             }
#           }
#         }
#       ]
#     }
#   )
# }

# resource "aws_iam_role_policy_attachment" "aws-ebs-csi-driver_attach" {
#   role       = aws_iam_role.aws-ebs-csi-driver.name
#   policy_arn = aws_iam_policy.aws-ebs-csi-driver-polcy.arn
# }

