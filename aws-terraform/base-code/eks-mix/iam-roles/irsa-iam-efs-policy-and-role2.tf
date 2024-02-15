variable "service_account_name_2" {
  type    = string
  default = "irsa-sevice-account-2"
}

# Resource: Create IAM Role and associate the EBS IAM Policy to it
resource "aws_iam_role" "irsa_iam_role_2" {
  name = "${var.control_plane_name}-irsa-iam-role-2"
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
            join(":", [split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1], "sub"]) : "system:serviceaccount:${var.namespace}:${var.service_account_name_2}"
          }
        }
      },
    ]
  })

  tags = {
    tag-key = "${data.aws_eks_cluster.example.id}-irsa-iam-role"
  }
}


# https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/docs/iam-policy-example.json
resource "aws_iam_policy" "efs-csi-driver-polcy_2" {
  name = "eks-efs-csi-driver-polcy-2"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "elasticfilesystem:DescribeAccessPoints",
            "elasticfilesystem:DescribeFileSystems",
            "elasticfilesystem:DescribeMountTargets",
            "ec2:DescribeAvailabilityZones"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "elasticfilesystem:CreateAccessPoint"
          ],
          "Resource" : "*",
          "Condition" : {
            "StringLike" : {
              "aws:RequestTag/efs.csi.aws.com/cluster" : "true"
            }
          }
        },
        {
          "Effect" : "Allow",
          "Action" : "elasticfilesystem:DeleteAccessPoint",
          "Resource" : "*",
          "Condition" : {
            "StringEquals" : {
              "aws:ResourceTag/efs.csi.aws.com/cluster" : "true"
            }
          }
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "test_attach" {
  role       = aws_iam_role.irsa_iam_role_2.name
  policy_arn = aws_iam_policy.efs-csi-driver-polcy_2.arn
}

