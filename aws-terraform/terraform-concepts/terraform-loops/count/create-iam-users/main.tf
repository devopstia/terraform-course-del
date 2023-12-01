terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "user_names_1" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["annie", "amy", "alain", "viviane"]
}

variable "user_names_2" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["paul", "peter", "tom", "smith"]
}

resource "aws_iam_user" "user1" {
  name = var.user_names_1[0]
}

resource "aws_iam_user" "user2" {
  name = var.user_names_1[1]
}

resource "aws_iam_user" "user3" {
  name = var.user_names_1[2]
}

resource "aws_iam_user" "user4" {
  name = var.user_names_1[3]
}

resource "aws_iam_user" "example" {
  count = length(var.user_names_2)
  name  = var.user_names_2[count.index]
}



