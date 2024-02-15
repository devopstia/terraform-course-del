# # Remove https on OpenID Connect provider URL
# # https://oidc.eks.us-east-1.amazonaws.com/id/51C78AC6ADC42A55DE543DFE84A03DE6
# output "identity-oidc-url" {
#   value = split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1]
# }

# output "aws_iam_openid_connect_provider_url" {
#   value = join("/", ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider", split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1]])
# }

# arn:aws:iam::788210522308:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/B1967613EBEE14A10B6520CE06D95B49
#  "https://oidc.eks.us-east-1.amazonaws.com/id/B1967613EBEE14A10B6520CE06D95B49"


variable "service_account_name_1" {
  type    = string
  default = "irsa-sevice-account-1"
}

variable "aws_iam_openid_connect_provider_arn_1" {
  type    = string
  default = "arn:aws:iam::788210522308:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/B1967613EBEE14A10B6520CE06D95B49"
}

# Remove https on OpenID Connect provider URL
# https://oidc.eks.us-east-1.amazonaws.com/id/51C78AC6ADC42A55DE543DFE84A03DE6
variable "aws_iam_openid_connect_provider_extract_from_ar_1" {
  type    = string
  default = "oidc.eks.us-east-1.amazonaws.com/id/B1967613EBEE14A10B6520CE06D95B49"
}


# Resource: Create IAM Role and associate the EBS IAM Policy to it
resource "aws_iam_role" "irsa_iam_role_1" {
  name = "${var.control_plane_name}-irsa-iam-role-1"

  # Terraform's "jsonencode" function converts a Terraform expression result to valid JSON syntax.
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
            join(":", [split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1], "sub"]) : "system:serviceaccount:${var.namespace}:${var.service_account_name_1}"
          }
        }
      },
    ]
  })

  tags = {
    tag-key = "${data.aws_eks_cluster.example.id}-irsa-iam-role-1"
  }
}


# Datasource: EFS CSI IAM Policy get from EFS GIT Repo (latest)
# https://github.com/kubernetes-sigs/aws-efs-csi-driver/tree/master/docs
# https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/docs/iam-policy-example.json
data "http" "efs_csi_iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-efs-csi-driver/master/docs/iam-policy-example.json"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}

output "efs_csi_iam_policy" {
  # to get the content
  value = data.http.efs_csi_iam_policy.body
}

# Resource: Create EFS CSI IAM Policy 
resource "aws_iam_policy" "efs_csi_iam_policy_1" {
  name        = "eks-efs-csi-driver-polcy-1"
  path        = "/"
  description = "EFS CSI IAM Policy"
  policy      = data.http.efs_csi_iam_policy.body
}

output "efs_csi_iam_policy_arn" {
  value = aws_iam_policy.efs_csi_iam_policy_1.arn
}


# Associate IAM Role and Policy
resource "aws_iam_role_policy_attachment" "irsa_iam_role_policy_attach" {
  policy_arn = aws_iam_policy.efs_csi_iam_policy_1.arn
  role       = aws_iam_role.irsa_iam_role_1.name
}






