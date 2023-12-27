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

variable "db_instance_types" {
  type    = list(string)
  default = ["db.t3.micro", "db.t3.small", "db.t3.medium"]
}

resource "aws_db_instance" "example" {
  for_each = { for idx, type in var.db_instance_types : idx => type }

  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = each.value
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

  tags = {
    Name        = "db-instance-${each.key}"
    Environment = "production" # Add environment tag
    Created_By  = "Terraform"
  }
}
