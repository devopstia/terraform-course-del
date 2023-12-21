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

resource "aws_instance" "example" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"
  root_block_device {
    volume_size = "10"
  }

  tags = {
    "Name"           = "bastion-host"
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning an Training"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              
              cat <<EOL > /var/www/html/index.html
              <!DOCTYPE html>
              <html>
              <body>
              <h1>Welcome to DevOps Easy Learning</h1>
              </body>
              </html>
              EOL
              
              systemctl enable apache2
              systemctl start apache2
              EOF
  lifecycle {
    ignore_changes = [
      user_data,
    ]
  }
}