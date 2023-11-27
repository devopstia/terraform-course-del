terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_group" "example_group" {
  name = "terraform-user-group"
}

resource "aws_iam_user" "example_user" {
  name = "terraform-user"
}

resource "aws_iam_policy_attachment" "example_group_attachment" {
  name       = "terraform-group-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  groups     = [aws_iam_group.example_group.name]
}

resource "aws_iam_group_membership" "example_membership" {
  name  = "example-membership"
  users = [aws_iam_user.example_user.name]
  group = aws_iam_group.example_group.name
}


