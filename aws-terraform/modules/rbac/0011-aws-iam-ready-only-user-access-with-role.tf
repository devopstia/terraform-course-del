resource "aws_iam_role" "ReadOnly-Role" {
  name = "AWS-ReadOnly-Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          # https://marcincuber.medium.com/amazon-eks-rbac-and-iam-access-f124f1164de7
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
      },
    ]
  })
  tags = {
    tag-key = "ReadOnly-Role"
  }
}


# https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/ReadOnlyAccess
resource "aws_iam_role_policy_attachment" "ReadOnlyAccess-attachment" {
  role       = aws_iam_role.ReadOnly-Role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/ReadOnlyAccess
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  role       = aws_iam_role.ReadOnly-Role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# https://antonputra.com/kubernetes/add-iam-user-and-iam-role-to-eks/#add-iam-user-to-eks-cluster
resource "aws_iam_policy" "AmazonEKSViewNodesAndWorkloadsPolicy" {
  name = "AmazonEKSViewNodesAndWorkloadsPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "eks:DescribeNodegroup",
          "eks:ListNodegroups",
          "eks:DescribeCluster",
          "eks:ListClusters",
          "eks:AccessKubernetesApi",
          "ssm:GetParameter",
          "eks:ListUpdates",
          "eks:ListFargateProfiles"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSViewNodesAndWorkloadsPolicy-attachment" {
  role       = aws_iam_role.ReadOnly-Role.name
  policy_arn = aws_iam_policy.AmazonEKSViewNodesAndWorkloadsPolicy.arn
}


# Resource: AWS IAM Group 
resource "aws_iam_group" "ADFS-AWS-ReadOnly" {
  name = "ADFS-AWS-ReadOnly"
  path = "/"
}

# Resource: AWS IAM Group Policy
resource "aws_iam_group_policy" "ADFS-AWS-ReadOnly-policy" {
  name  = "ADFS-AWS-ReadOnly-Policy"
  group = aws_iam_group.ADFS-AWS-ReadOnly.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Sid      = ""
        Resource = "${aws_iam_role.ReadOnly-Role.arn}"
      },
    ]
  })
}


# Resource: AWS IAM User - Basic User 
resource "aws_iam_user" "aws-readony-user-1" {
  name          = "aws-readony-user-1"
  path          = "/"
  force_destroy = true
  tags = {
    Name = "aws-readony-user-user-1"
  }
}

resource "aws_iam_user" "aws-readony-user-2" {
  name          = "aws-readony-user-2"
  path          = "/"
  force_destroy = true
  tags = {
    Name = "aws-readony-user-user-2"
  }
}

resource "aws_iam_user" "aws-readony-user-3" {
  name          = "aws-readony-user-3"
  path          = "/"
  force_destroy = true
  tags = {
    Name = "aws-readony-user-user-3"
  }
}


# Resource: AWS IAM Group Membership
resource "aws_iam_group_membership" "ADFS-AWS-ReadOnly-membership" {
  name = "ADFS-AWS-ReadOnly-Membership"
  users = [
    aws_iam_user.aws-readony-user-1.name,
    aws_iam_user.aws-readony-user-2.name,
    aws_iam_user.aws-readony-user-3.name,
  ]
  group = aws_iam_group.ADFS-AWS-ReadOnly.name
}


# https://stackoverflow.com/questions/47514945/what-is-sid-attribute-use-for-in-key-policies
resource "aws_iam_policy" "allow-deny-aws-console" {
  name = "allow-deny-aws-console"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "S3PublicActions",
        "Effect" : "Deny",
        "Action" : [
          "s3:PutBucketPublicAccessBlock",
          "s3:PutAccountPublicAccessBlock"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Sid" : "ParameterStoreDeny",
        "Effect" : "Deny",
        "Action" : [
          "ssm:Describe*",
          "ssm:Get*",
          "ssm:List*"
        ],
        "Resource" : [
          "*"
        ]
      },
      {
        "Sid" : "AllowUsersToListUsersInConsole",
        "Effect" : "Deny",
        "Action" : [
          "iam:ListUsers"
        ],
        "Resource" : [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/*"
        ]
      },
      {
        "Sid" : "DenyAccessToSecretManager",
        "Effect" : "Deny",
        "Action" : [
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets"
        ],
        "Resource" : "*"
      },
      # {
      #     "Sid": "DenyAccessToS3",
      #     "Effect": "Deny",
      #     "Action": [
      #         "s3:*",
      #     ],
      #     "Resource": "*"
      # },
      {
        "Sid" : "DenyAccessToS3",
        "Effect" : "Deny",
        "Action" : [
          "s3:*"
        ],
        "Resource" : [
          "arn:aws:s3:::warfiles-for-docker",
          "arn:aws:s3:::warfiles-for-docker/*",
          "arn:aws:s3:::2560-dev-alpha-terraform-state",
          "arn:aws:s3:::2560-dev-alpha-terraform-state/*",
          "arn:aws:s3:::del-terraform-state",
          "arn:aws:s3:::del-terraform-state/*"
        ],
      },
      {
        "Sid" : "AllowReadonly",
        "Effect" : "Allow",
        "Action" : [
          "appstream:Get*",
          "autoscaling:Describe*",
          "aws-portal:ViewAccount",
          "aws-portal:ViewBilling",
          "aws-portal:ViewPaymentMethods",
          "aws-portal:ViewUsage",
          "cloudformation:DescribeStackEvents",
          "cloudformation:DescribeStackResources",
          "cloudformation:DescribeStacks",
          "cloudformation:GetTemplate",
          "cloudformation:List*",
          "cloudfront:Get*",
          "cloudfront:List*",
          "cloudtrail:DescribeTrails",
          "cloudtrail:GetTrailStatus",
          "cloudwatch:Describe*",
          "cloudwatch:Describe*",
          "cloudwatch:DescribeAlarmHistory",
          "cloudwatch:DescribeAlarms",
          "cloudwatch:DescribeAlarmsForMetric",
          "cloudwatch:Get*",
          "cloudwatch:Get*",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:List*",
          "cloudwatch:List*",
          "cloudwatch:ListMetrics",
          "directconnect:Describe*",
          "dynamodb:BatchGetItem",
          "dynamodb:DescribeTable",
          "dynamodb:GetItem",
          "dynamodb:ListTables",
          "dynamodb:Query",
          "dynamodb:Scan",
          "ec2:Describe*",
          "ecr:Describe*",
          "ecr:List*",
          "ecs:Describe*",
          "ecs:List*",
          "elasticache:Describe*",
          "elasticbeanstalk:Check*",
          "elasticbeanstalk:Describe*",
          "elasticbeanstalk:List*",
          "elasticbeanstalk:RequestEnvironmentInfo",
          "elasticbeanstalk:RetrieveEnvironmentInfo",
          "elasticloadbalancing:Describe*",
          "elastictranscoder:List*",
          "elastictranscoder:Read*",
          "es:Describe*",
          "es:List*",
          "iam:Get*",
          "iam:GetAccount*",
          "iam:List*",
          "iam:ListAccount*",
          "kinesis:Describe*",
          "kinesis:List*",
          "logs:FilterLogEvents",
          "opsworks:Describe*",
          "opsworks:Get*",
          "rds:Describe*",
          "rds:Describe*",
          "rds:Download*",
          "rds:ListTagsForResource",
          "rds:ListTagsForResource",
          "redshift:Describe*",
          "redshift:ViewQueriesInConsole",
          "route53:Get*",
          "route53:List*",
          "s3:Get*",
          "s3:List*",
          "sdb:GetAttributes",
          "sdb:List*",
          "sdb:Select*",
          "ses:Get*",
          "ses:List*",
          "snowball:Describe*",
          "snowball:GetJobManifest",
          "snowball:GetSnowballUsage",
          "snowball:List*",
          "sns:Get*",
          "sns:List*",
          "sqs:GetQueueAttributes",
          "sqs:ListQueues",
          "sqs:ReceiveMessage",
          "states:DescribeActivity",
          "states:DescribeExecution",
          "states:DescribeStateMachine",
          "states:GetExecutionHistory",
          "states:ListActivities",
          "states:ListExecutions",
          "states:ListStateMachines",
          "storagegateway:Describe*",
          "storagegateway:List*",
          "support:*",
          "tag:getResources",
          "tag:getTagKeys",
          "tag:getTagValues",
          "waf-regional:Get*",
          "waf-regional:List*"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "allow-deny-aws-console-polcy-attachment" {
  role       = aws_iam_role.ReadOnly-Role.name
  policy_arn = aws_iam_policy.allow-deny-aws-console.arn
}

