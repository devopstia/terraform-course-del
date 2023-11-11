# terraform-examples

```s
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

# Define a list of instance names
variable "instance_names" {
  type    = list(string)
  default = ["instance-1", "instance-2", "instance-3"]
}

# Create lists of AMIs, instance types, and key names
variable "amis" {
  type    = list(string)
  default = ["ami-1", "ami-2", "ami-3"]
}

variable "instance_types" {
  type    = list(string)
  default = ["t2.micro", "t2.small", "t2.medium"]
}

variable "key_names" {
  type    = list(string)
  default = ["key-1", "key-2", "key-3"]
}

# Create a list of availability zones, subnets, and security groups
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "subnets" {
  type    = list(string)
  default = ["subnet-1", "subnet-2", "subnet-3"]
}

variable "security_groups" {
  type    = list(string)
  default = ["sg-1", "sg-2", "sg-3"]
}

resource "aws_instance" "vm" {
  count = length(var.instance_names)

  ami                    = element(var.amis, count.index)
  instance_type          = element(var.instance_types, count.index)
  key_name               = element(var.key_names, count.index)
  subnet_id              = element(var.subnets, count.index)
  vpc_security_group_ids = [element(var.security_groups, count.index)]
  availability_zone      = element(var.availability_zones, count.index)

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name      = element(var.instance_names, count.index)
    Create_By = "Terraform"
  }
}
```


```s
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

# Define a list of instance configurations
variable "instance_configurations" {
  type = list(object({
    name          = string
    ami           = string
    instance_type = string
    key_name      = string
  }))
  default = [
    {
      name          = "instance-1"
      ami           = "ami-1"
      instance_type = "t2.micro"
      key_name      = "key-1"
    },
    {
      name          = "instance-2"
      ami           = "ami-2"
      instance_type = "t2.small"
      key_name      = "key-2"
    },
    {
      name          = "instance-3"
      ami           = "ami-3"
      instance_type = "t2.medium"
      key_name      = "key-3"
    }
  ]
}

# Create lists of availability zones, subnets, and security groups
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "subnets" {
  type    = list(string)
  default = ["subnet-1", "subnet-2", "subnet-3"]
}

variable "security_groups" {
  type    = list(string)
  default = ["sg-1", "sg-2", "sg-3"]
}

resource "aws_instance" "vm" {
  for_each = { for idx, instance in var.instance_configurations : idx => instance }

  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  key_name               = each.value.key_name
  subnet_id              = element(var.subnets, each.key)
  vpc_security_group_ids = [element(var.security_groups, each.key)]
  availability_zone      = element(var.availability_zones, each.key)

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name      = each.value.name
    Create_By = "Terraform"
  }
}

```