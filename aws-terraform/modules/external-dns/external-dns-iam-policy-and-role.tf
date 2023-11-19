resource "aws_iam_role" "external-dns" {
  name = format("%s-%s-%s-external-iam-role", var.tags["id"], var.tags["environment"], var.tags["project"])
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
            join(":", [split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1], "sub"]) : "system:serviceaccount:${var.external-dns-ns}:${var.external-dns-sa}"
          }
        }
      },
    ]
  })

  tags = {
    tag-key = format("%s-%s-%s-external-iam-role", var.tags["id"], var.tags["environment"], var.tags["project"])
  }
}

resource "aws_iam_policy" "external-dns-polcy" {
  name        = format("%s-%s-%s-external-iam-policy", var.tags["id"], var.tags["environment"], var.tags["project"])
  path        = "/"
  description = "External DNS IAM Policy"
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "route53:ChangeResourceRecordSets"
          ],
          "Resource" : [
            "arn:aws:route53:::hostedzone/*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "route53:ListHostedZones",
            "route53:ListResourceRecordSets"
          ],
          "Resource" : [
            "*"
          ]
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "external-dns_attach" {
  role       = aws_iam_role.external-dns.name
  policy_arn = aws_iam_policy.external-dns-polcy.arn
}

