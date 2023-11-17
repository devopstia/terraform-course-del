## Example
```s
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

resource "aws_instance" "vm" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "terraform-aws"
  vpc_security_group_ids = ["sg-0c51540c60857b7ed"]
  subnet_id              = "subnet-096d45c28d9fb4c14"

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name      = "vm"
    Create_By = "Terraform"
  }
}


resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
  number  = false
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-unique-bucket-${random_string.bucket_suffix.result}"

  tags = {
    Name      = "my-unique-bucket-${random_string.bucket_suffix.result}"
    Create_By = "Terraform"
  }
}

```

## convert to json
```s
common_tags = {
  "AssetID"       = "2560"
  "AssetName"     = "Insfrastructure"
  "Environment"   = "dev"
  "Project"       = "alpha"
  "CreateBy"      = "Terraform"
  "cloudProvider" = "aws"
}

aws_region              = "us-east-1"
private_subnets_eks_ec2 = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets_db      = ["10.0.3.0/24", "10.0.4.0/24"]
public                  = ["10.0.5.0/24", "10.0.6.0/24"]
aws_availability_zones  = ["us-east-1a", "us-east-1b"]

cidr_block                       = "10.0.0.0/16"
instance_tenancy                 = "default"
enable_dns_support               = true
enable_dns_hostnames             = true
enable_classiclink               = false
enable_classiclink_dns_support   = false
assign_generated_ipv6_cidr_block = false

cluster_name = "2560-dev-alpha"
```

```json
{
  "common_tags": {
    "AssetID": "2560",
    "AssetName": "Insfrastructure",
    "Environment": "dev",
    "Project": "alpha",
    "CreateBy": "Terraform",
    "cloudProvider": "aws"
  },
  "aws_region": "us-east-1",
  "private_subnets_eks_ec2": [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ],
  "private_subnets_db": [
    "10.0.3.0/24",
    "10.0.4.0/24"
  ],
  "public": [
    "10.0.5.0/24",
    "10.0.6.0/24"
  ],
  "aws_availability_zones": [
    "us-east-1a",
    "us-east-1b"
  ],
  "cidr_block": "10.0.0.0/16",
  "instance_tenancy": "default",
  "enable_dns_support": true,
  "enable_dns_hostnames": true,
  "enable_classiclink": false,
  "enable_classiclink_dns_support": false,
  "assign_generated_ipv6_cidr_block": false,
  "cluster_name": "2560-dev-alpha"
}
```

OR

```json
{
  "common_tags": {
    "AssetID": "2560",
    "AssetName": "Insfrastructure",
    "Environment": "dev",
    "Project": "alpha",
    "CreateBy": "Terraform",
    "cloudProvider": "aws"
  },
  "aws_region": "us-east-1",
  "private_subnets_eks_ec2": ["10.0.1.0/24", "10.0.2.0/24"],
  "private_subnets_db": ["10.0.3.0/24", "10.0.4.0/24"],
  "public": ["10.0.5.0/24", "10.0.6.0/24"],
  "aws_availability_zones": ["us-east-1a", "us-east-1b"],
  "cidr_block": "10.0.0.0/16",
  "instance_tenancy": "default",
  "enable_dns_support": true,
  "enable_dns_hostnames": true,
  "enable_classiclink": false,
  "enable_classiclink_dns_support": false,
  "assign_generated_ipv6_cidr_block": false,
  "cluster_name": "2560-dev-alpha"
}
```

## Variable file
```s
variable "common_tags" {
  type    = map(string)
  default = {
    "AssetID"       = "2560"
    "AssetName"     = "Insfrastructure"
    "Environment"   = "dev"
    "Project"       = "alpha"
    "CreateBy"      = "Terraform"
    "cloudProvider" = "aws"
  }
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "private_subnets_eks_ec2" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_db" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "public" {
  type    = list(string)
  default = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "aws_availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "instance_tenancy" {
  type    = string
  default = "default"
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "enable_classiclink" {
  type    = bool
  default = false
}

variable "enable_classiclink_dns_support" {
  type    = bool
  default = false
}

variable "assign_generated_ipv6_cidr_block" {
  type    = bool
  default = false
}

variable "cluster_name" {
  type    = string
  default = "2560-dev-alpha"
}

```