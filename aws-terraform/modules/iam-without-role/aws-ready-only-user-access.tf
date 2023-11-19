resource "aws_iam_group" "aws-readonly-group" {
  name = var.aws-readonly-group
}

resource "aws_iam_user" "aws-readonly-users" {
  for_each = var.aws-readonly-users
  name     = each.value
}

resource "aws_iam_group_policy" "aws-readonly-policy" {
  name  = format("%s-%s-%s-aws-readonly-policy", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
  group = aws_iam_group.aws-readonly-group.name

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
      # deny access to all s3
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
          "arn:aws:s3:::linux-devops-course",
          "arn:aws:s3:::linux-devops-course/*",
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

resource "aws_iam_group_membership" "aws-readonly-group-membership" {
  for_each = aws_iam_user.aws-readonly-users

  name  = each.key
  users = [aws_iam_user.aws-readonly-users[each.key].name]
  group = aws_iam_group.aws-readonly-group.name
}
