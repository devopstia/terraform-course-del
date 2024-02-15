
# variable "aws-load-balancer-controller-ns" {
#   type    = string
#   default = "aws-load-balancer-controller"
# }

# variable "aws-load-balancer-controller-sa-name" {
#   type    = string
#   default = "aws-load-balancer-controller-sa"
# }

# resource "aws_iam_role" "aws-load-balancer-controller-role" {
#   name = "aws-load-balancer-controller-role"
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
#             join(":", [split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1], "sub"]) : "system:serviceaccount:${var.aws-load-balancer-controller-ns}:${var.aws-load-balancer-controller-sa-name}"
#           }
#         }
#       },
#     ]
#   })

#   tags = {
#     tag-key = "${data.aws_eks_cluster.example.id}-irsa-aws-load-balancer-controller-role"
#   }
# }

# # https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/iam-policy.json
# # If we to not create this role and enable service account create to true, 
# # a default service account will be created with this default policy
# resource "aws_iam_role_policy" "aws-load-balancer-controller-role-policy" {
#   name = "aws-load-balancer-controller-role-policy"
#   role = aws_iam_role.aws-load-balancer-controller-role.name

#   policy = jsonencode({
#     Version = "2012-10-17"
#     "Statement" : [
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "acm:DescribeCertificate",
#           "acm:ListCertificates",
#           "acm:GetCertificate"
#         ],
#         "Resource" : "*"
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "ec2:AuthorizeSecurityGroupIngress",
#           "ec2:CreateSecurityGroup",
#           "ec2:CreateTags",
#           "ec2:DeleteTags",
#           "ec2:DeleteSecurityGroup",
#           "ec2:DescribeAccountAttributes",
#           "ec2:DescribeAddresses",
#           "ec2:DescribeInstances",
#           "ec2:DescribeInstanceStatus",
#           "ec2:DescribeInternetGateways",
#           "ec2:DescribeNetworkInterfaces",
#           "ec2:DescribeSecurityGroups",
#           "ec2:DescribeSubnets",
#           "ec2:DescribeTags",
#           "ec2:DescribeVpcs",
#           "ec2:ModifyInstanceAttribute",
#           "ec2:ModifyNetworkInterfaceAttribute",
#           "ec2:RevokeSecurityGroupIngress"
#         ],
#         "Resource" : "*"
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "elasticloadbalancing:AddListenerCertificates",
#           "elasticloadbalancing:AddTags",
#           "elasticloadbalancing:CreateListener",
#           "elasticloadbalancing:CreateLoadBalancer",
#           "elasticloadbalancing:CreateRule",
#           "elasticloadbalancing:CreateTargetGroup",
#           "elasticloadbalancing:DeleteListener",
#           "elasticloadbalancing:DeleteLoadBalancer",
#           "elasticloadbalancing:DeleteRule",
#           "elasticloadbalancing:DeleteTargetGroup",
#           "elasticloadbalancing:DeregisterTargets",
#           "elasticloadbalancing:DescribeListenerCertificates",
#           "elasticloadbalancing:DescribeListeners",
#           "elasticloadbalancing:DescribeLoadBalancers",
#           "elasticloadbalancing:DescribeLoadBalancerAttributes",
#           "elasticloadbalancing:DescribeRules",
#           "elasticloadbalancing:DescribeSSLPolicies",
#           "elasticloadbalancing:DescribeTags",
#           "elasticloadbalancing:DescribeTargetGroups",
#           "elasticloadbalancing:DescribeTargetGroupAttributes",
#           "elasticloadbalancing:DescribeTargetHealth",
#           "elasticloadbalancing:ModifyListener",
#           "elasticloadbalancing:ModifyLoadBalancerAttributes",
#           "elasticloadbalancing:ModifyRule",
#           "elasticloadbalancing:ModifyTargetGroup",
#           "elasticloadbalancing:ModifyTargetGroupAttributes",
#           "elasticloadbalancing:RegisterTargets",
#           "elasticloadbalancing:RemoveListenerCertificates",
#           "elasticloadbalancing:RemoveTags",
#           "elasticloadbalancing:SetIpAddressType",
#           "elasticloadbalancing:SetSecurityGroups",
#           "elasticloadbalancing:SetSubnets",
#           "elasticloadbalancing:SetWebAcl"
#         ],
#         "Resource" : "*"
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "iam:CreateServiceLinkedRole",
#           "iam:GetServerCertificate",
#           "iam:ListServerCertificates"
#         ],
#         "Resource" : "*"
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "cognito-idp:DescribeUserPoolClient"
#         ],
#         "Resource" : "*"
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "waf-regional:GetWebACLForResource",
#           "waf-regional:GetWebACL",
#           "waf-regional:AssociateWebACL",
#           "waf-regional:DisassociateWebACL"
#         ],
#         "Resource" : "*"
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "tag:GetResources",
#           "tag:TagResources"
#         ],
#         "Resource" : "*"
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "waf:GetWebACL"
#         ],
#         "Resource" : "*"
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "wafv2:GetWebACL",
#           "wafv2:GetWebACLForResource",
#           "wafv2:AssociateWebACL",
#           "wafv2:DisassociateWebACL"
#         ],
#         "Resource" : "*"
#       },
#       {
#         "Effect" : "Allow",
#         "Action" : [
#           "shield:DescribeProtection",
#           "shield:GetSubscriptionState",
#           "shield:DeleteProtection",
#           "shield:CreateProtection",
#           "shield:DescribeSubscription",
#           "shield:ListProtections"
#         ],
#         "Resource" : "*"
#       }
#     ]
#   })
# }
