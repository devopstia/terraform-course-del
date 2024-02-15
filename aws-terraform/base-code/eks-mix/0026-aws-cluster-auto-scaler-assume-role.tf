# resource "aws_iam_policy" "cluster-autoscaler-asume-polcy" {
#   name = "cluster-autoscaler-asume-polcy"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "autoscaling:DescribeAutoScalingGroups",
#           "autoscaling:DescribeAutoScalingInstances",
#           "autoscaling:DescribeLaunchConfigurations",
#           "autoscaling:DescribeTags",
#           "autoscaling:SetDesiredCapacity",
#           "autoscaling:TerminateInstanceInAutoScalingGroup",
#           "ec2:DescribeLaunchTemplateVersions"
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "cluster-autoscaler-policy-attachment" {
#   role       = aws_iam_role.nodes.name
#   policy_arn = aws_iam_policy.cluster-autoscaler-asume-polcy.arn
# }
