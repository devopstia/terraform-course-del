resource "aws_iam_group" "aws-admin-group" {
  name = var.aws-admin-group
}

resource "aws_iam_user" "aws-admin-users" {
  for_each = var.aws-admin-users
  name     = each.value
}

resource "aws_iam_group_policy" "admin-group-policy" {
  name  = format("%s-%s-%s-admin-group-policy", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
  group = aws_iam_group.aws-admin-group.name

  policy = jsonencode({
    Version = "2012-10-17"
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "*",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_group_membership" "aws-admin-group-membership" {
  for_each = aws_iam_user.aws-admin-users
  name     = each.key
  users    = [aws_iam_user.aws-admin-users[each.key].name]
  group    = aws_iam_group.aws-admin-group.name
}
