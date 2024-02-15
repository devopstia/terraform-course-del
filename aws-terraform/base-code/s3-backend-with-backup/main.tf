##################################################################################################
#Terraform State Bucket
##################################################################################################

resource "aws_iam_role" "replication" {
  provider = "aws.state"
  name     = "tf-iam-role-replication"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
  tags               = var.common_tags
}

resource "aws_iam_policy" "replication" {
  provider = "aws.state"
  name     = "tf-iam-role-policy-replication"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.state.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.state.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.backup.arn}/*"
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "replication" {
  provider   = "aws.state"
  name       = "tf-iam-role-attachment-replication"
  roles      = ["${aws_iam_role.replication.name}"]
  policy_arn = aws_iam_policy.replication.arn
}

resource "aws_s3_bucket" "state" {
  provider = "aws.state"
  bucket   = "${var.env_type}-${var.project_name}-tf-state"
  acl      = "private"
  versioning {
    enabled = true
  }

  replication_configuration {
    role = aws_iam_role.replication.arn

    rules {
      id     = "StateReplicationAll"
      prefix = ""
      status = "Enabled"

      destination {
        bucket        = aws_s3_bucket.backup.arn
        storage_class = "STANDARD"
      }
    }
  }
  tags = var.common_tags
}


resource "aws_s3_bucket" "backup" {
  provider = "aws.backup"
  bucket   = "${var.env_type}-${var.project_name}-tf-state-backup"
  versioning {
    enabled = true
  }
  tags = var.common_tags
}


resource "aws_dynamodb_table" "tf-state-lock" {
  provider       = "aws.state"
  name           = "${var.env_type}-${var.project_name}-tf-state-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = var.common_tags
}

