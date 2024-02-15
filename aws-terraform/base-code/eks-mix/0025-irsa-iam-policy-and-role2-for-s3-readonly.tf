
# variable "asume-role-s3-read-only-ns" {
#   type    = string
#   default = "dev"
# }

# variable "asume-role-s3-read-only-sa-name" {
#   type    = string
#   default = "asume-role-s3-read-only-sa"
# }

# resource "aws_iam_role" "irsa_iam_role_for_s3_readony" {
#   name = "asume-role-s3-read-only"
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
#             join(":", [split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1], "sub"]) : "system:serviceaccount:${var.asume-role-s3-read-only-ns}:${var.asume-role-s3-read-only-sa-name}"
#           }
#         }
#       },
#     ]
#   })

#   tags = {
#     tag-key = "${data.aws_eks_cluster.example.id}-irsa-iam-role-for-s3-readony"
#   }
# }

# resource "aws_iam_role_policy_attachment" "policy_attachment_for_s3_readony" {
#   role       = aws_iam_role.irsa_iam_role_for_s3_readony.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
# }
