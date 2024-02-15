
variable "ns" {
  type    = string
  default = "app"
}

variable "sa-name" {
  type    = string
  default = "irsa-service-account-for-s3-readony"
}

resource "aws_iam_role" "irsa_iam_role_for_s3_readony" {
  name = "${var.control_plane_name}-irsa-iam-role-for-s3-readony"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = join("/", ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider", split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1]])
        }
        Condition = {
          StringEquals = {
            join(":", [split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1], "sub"]) : "system:serviceaccount:${var.ns}:${var.sa-name}"
          }
        }
      },
    ]
  })

  tags = {
    tag-key = "${data.aws_eks_cluster.example.id}-irsa-iam-role-for-s3-readony"
  }
}

resource "aws_iam_role_policy_attachment" "policy_attachment_for_s3_readony" {
  role       = aws_iam_role.irsa_iam_role_for_s3_readony.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
