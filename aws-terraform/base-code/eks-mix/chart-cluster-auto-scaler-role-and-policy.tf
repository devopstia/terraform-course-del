# variable "cluster-autoscaler-sa" {
#   type    = string
#   default = "cluster-autoscaler-sa"
# }

# variable "cluster-autoscaler-ns" {
#   type    = string
#   default = "cluster-autoscaler"
# }

# resource "aws_iam_role" "cluster-autoscaler" {
#   name = "${var.control_plane_name}-cluster-autoscaler-iam-role"
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
#             join(":", [split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1], "sub"]) : "system:serviceaccount:${var.cluster-autoscaler-ns}:${var.cluster-autoscaler-sa}"
#           }
#         }
#       },
#     ]
#   })

#   tags = {
#     tag-key = "${data.aws_eks_cluster.example.id}-cluster-autoscaler-iam-role"
#   }
# }

# # https://raw.githubusercontent.com/kubernetes-sigs/cluster-autoscaler/main/docs/install/iam_policy.json
# resource "aws_iam_policy" "cluster-autoscaler-polcy" {
#   name        = "cluster-autoscaler-polcy"
#   path        = "/"
#   description = "External DNS IAM Policy"
#   policy = jsonencode(
#     {
#       "Version" : "2012-10-17",
#       "Statement" : [
#         {
#           "Action" : [
#             "autoscaling:DescribeAutoScalingGroups",
#             "autoscaling:DescribeAutoScalingInstances",
#             "autoscaling:DescribeInstances",
#             "autoscaling:DescribeLaunchConfigurations",
#             "autoscaling:DescribeTags",
#             "autoscaling:SetDesiredCapacity",
#             "autoscaling:TerminateInstanceInAutoScalingGroup",
#             "ec2:DescribeLaunchTemplateVersions",
#             "ec2:DescribeInstanceTypes"
#           ],
#           "Resource" : "*",
#           "Effect" : "Allow"
#         }
#       ]
#     }
#   )
# }

# resource "aws_iam_role_policy_attachment" "cluster-autoscaler_attach" {
#   role       = aws_iam_role.cluster-autoscaler.name
#   policy_arn = aws_iam_policy.cluster-autoscaler-polcy.arn
# }

