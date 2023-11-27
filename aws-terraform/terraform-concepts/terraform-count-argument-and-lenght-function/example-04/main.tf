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

variable "instance_configurations" {
  type = list(object({
    ami                = string
    instance_type      = string
    key_name           = string
    subnet_id          = string
    security_group_ids = list(string)
    tags               = map(string)
    ebs_block_device = list(object({
      device_name           = string
      volume_type           = string
      volume_size           = number
      delete_on_termination = bool
    }))
  }))
  default = [
    {
      ami                    = "ami-0fc5d935ebf8bc3bc"
      instance_type          = "t2.micro"
      key_name               = "terraform-aws"
      subnet_id              = "subnet-096d45c28d9fb4c14"
      vpc_security_group_ids = ["sg-12345678"]
      tags = {
        Name      = "vm1"
        Create_By = "Terraform"
      }
      ebs_block_device = [
        {
          device_name           = "/dev/sda1"
          volume_type           = "gp2"
          volume_size           = 20
          delete_on_termination = true
        }
      ]
    },
    {
      ami                = "ami-0fc5d935ebf8bc3bc"
      instance_type      = "m4.large"
      key_name           = "dev-key"
      subnet_id          = "subnet-096d45c28d9fb4c15"
      security_group_ids = ["sg-87654321"]
      tags = {
        Name      = "vm2"
        Create_By = "Terraform"
      }
      ebs_block_device = [
        {
          device_name           = "/dev/sda1"
          volume_type           = "gp2"
          volume_size           = 20
          delete_on_termination = true
        }
      ]
    },
    {
      ami                = "ami-0fc5d935ebf8bc3bc"
      instance_type      = "c5.xlarge"
      key_name           = "admin-key"
      subnet_id          = "subnet-096d45c28d9fb4c16"
      security_group_ids = ["sg-99999999"]
      tags = {
        Name      = "vm3"
        Create_By = "Terraform"
      }
      ebs_block_device = [
        {
          device_name           = "/dev/sdb"
          volume_type           = "gp2"
          volume_size           = 30
          delete_on_termination = true
        }
      ]
    }
  ]
}


resource "aws_instance" "example" {
  count = length(var.instance_configurations)

  ami                    = var.instance_configurations[count.index].ami
  instance_type          = var.instance_configurations[count.index].instance_type
  key_name               = var.instance_configurations[count.index].key_name
  subnet_id              = var.instance_configurations[count.index].subnet_id
  vpc_security_group_ids = [var.instance_configurations[count.index].vpc_security_group_ids]

  ebs_block_device {
    device_name           = var.instance_configurations[count.index].ebs_block_device[0].device_name
    volume_type           = var.instance_configurations[count.index].ebs_block_device[0].volume_type
    volume_size           = var.instance_configurations[count.index].ebs_block_device[0].volume_size
    delete_on_termination = var.instance_configurations[count.index].ebs_block_device[0].delete_on_termination
  }

  tags = var.instance_configurations[count.index].tags
}


