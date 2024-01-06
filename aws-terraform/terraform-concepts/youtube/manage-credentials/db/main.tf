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

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = data.aws_secretsmanager_secret_version.rds_username.secret_string
  password             = data.aws_secretsmanager_secret_version.rds_password.secret_string
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}


