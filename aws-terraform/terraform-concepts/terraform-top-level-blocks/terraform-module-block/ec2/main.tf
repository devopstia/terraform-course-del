provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.0.0"
}

locals {
  user_data = <<-EOT
    #!/bin/bash
    echo "Hello Terraform!"
  EOT
  tags = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "development"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}

module "ec2_instance" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  instance_type          = "t2.micro"
  name                   = format("%s-%s-%s-vm", local.tags["id"], local.tags["environment"], local.tags["project"])
  ami                    = "ami-0fc5d935ebf8bc3bc"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"
  user_data_base64       = base64encode(local.user_data)
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      volume_size = 10
    },
  ]
  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = 5
      encrypted   = true
    }
  ]
  tags = local.tags
}


