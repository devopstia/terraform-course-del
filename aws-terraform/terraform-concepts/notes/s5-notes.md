i
```s
provider "aws" {
  # Configure your AWS provider settings here
}

variable "family" {
  type = list(string)
  default = [
    "paul",
    "tom",
    "john",
    "tonton",
    "tata"
  ]
}

resource "aws_iam_user" "family_users" {
  count = length(var.family)
  name = var.family[count.index]
}

resource "aws_iam_user" "family_users1" {
  name = "paul"
}

resource "aws_iam_user" "family_users2" {
  name = "tom"
}

resource "aws_iam_user" "family_users3" {
  name = "john"
}

resource "aws_iam_user" "family_users4" {
  name = "tonton"
}

resource "aws_iam_user" "family_users5" {
  name = "tata"
}
```


```s
terraform {
  required_version = "~> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "family" {
  type = list(string)
  default = [
    "paul",
    "tom",
    "john",
    "tonton",
    "tata"
  ]
}


resource "aws_instance" "example" {
  count                  = "5"
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed", "sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"
  root_block_device {
    volume_size = "10"
  }
  tags = {
    Name      = "vm-${count.index + 1}"
    Create_By = "Terraform"
  }
}
```

