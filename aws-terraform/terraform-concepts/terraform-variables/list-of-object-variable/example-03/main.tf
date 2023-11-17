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
  region = "us-east-1" # Specify the common region for all instances
}

# Define a list variable to store instance configurations
variable "instance_configs" {
  type = list(object({
    ami                    = string
    instance_type          = string
    key_name               = string
    vpc_security_group_ids = list(string)
    subnet_id              = string
    volume_size            = string
    tags                   = map(string)
  }))
  default = [
    {
      ami                    = "ami-0fc5d935ebf8bc3bc"
      instance_type          = "t2.micro"
      key_name               = "terraform-aws"
      vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
      subnet_id              = "subnet-096d45c28d9fb4c14"
      volume_size            = "10"
      tags = {
        Name      = "vm-1"
        Create_By = "Terraform"
      }
    },
    {
      ami                    = "ami-0fc5d935ebf8bc3bc"
      instance_type          = "t2.small"
      key_name               = "my-key"
      vpc_security_group_ids = ["sg-0123456789abcdef0"]
      subnet_id              = "subnet-096d45c28d9fb4c14" # Same subnet for all instances
      volume_size            = "20"
      tags = {
        Name      = "vm-2"
        Create_By = "Terraform"
      }
    }
    # Add more instance configurations here if needed
  ]
}

# Create AWS instances using the list variable
resource "aws_instance" "example" {
  count = length(var.instance_configs)

  ami                    = var.instance_configs[count.index].ami
  instance_type          = var.instance_configs[count.index].instance_type
  key_name               = var.instance_configs[count.index].key_name
  vpc_security_group_ids = var.instance_configs[count.index].vpc_security_group_ids
  subnet_id              = var.instance_configs[count.index].subnet_id

  root_block_device {
    volume_size = var.instance_configs[count.index].volume_size
  }

  tags = var.instance_configs[count.index].tags
}
