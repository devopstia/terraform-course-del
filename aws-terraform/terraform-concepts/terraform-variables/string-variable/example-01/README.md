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

## Example variable for EKS node
```s
# variable.tf

# Define an object variable for the configuration
variable "config" {
  description = "Configuration settings for the infrastructure."
  type = object({
    aws_region         = string
    control_plane_name = string
    private_subnets = map(string)
    eks_version  = string
    node_min     = string
    desired_node = string
    node_max     = string
    blue_node_color  = string
    green_node_color = string
    blue  = bool
    green = bool
    ec2_ssh_key               = string
    deployment_nodegroup      = string
    capacity_type             = string
    ami_type                  = string
    instance_types            = string
    disk_size                 = string
    shared_owned              = string
    enable_cluster_autoscaler = string
    tags = map(string)
  })
  default = {
    aws_region         = "us-east-1"
    control_plane_name = "2560-dev-del"
    private_subnets = {
      us-east-1a = "subnet-0346f91f492ccfaa8"
      us-east-1b = "subnet-0d4e63819baf2844c"
      us-east-1c = "subnet-02622d73204514286"
    }
    eks_version  = "1.24"
    node_min     = "1"
    desired_node = "1"
    node_max     = "6"
    blue_node_color  = "blue"
    green_node_color = "green"
    blue  = false
    green = true
    ec2_ssh_key               = "terraform-aws"
    deployment_nodegroup      = "blue_green"
    capacity_type             = "ON_DEMAND"
    ami_type                  = "AL2_x86_64"
    instance_types            = "t2.medium"
    disk_size                 = "10"
    shared_owned              = "shared"
    enable_cluster_autoscaler = "true"
    tags = {
      "id"             = "2560"
      "owner"          = "DevOps Easy Learning"
      "teams"          = "DEL"
      "environment"    = "dev"
      "project"        = "del"
      "create_by"      = "Terraform"
      "cloud_provider" = "aws"
    }
  }
}
```

## terraform.tfvars
```s
config {
  aws_region         = "us-east-1"
  control_plane_name = "2560-dev-del"
  private_subnets = {
    us-east-1a = "subnet-0346f91f492ccfaa8"
    us-east-1b = "subnet-0d4e63819baf2844c"
    us-east-1c = "subnet-02622d73204514286"
  }
  eks_version  = "1.24"
  node_min     = "1"
  desired_node = "1"
  node_max     = "6"
  blue_node_color  = "blue"
  green_node_color = "green"
  blue  = false
  green = true
  ec2_ssh_key               = "terraform-aws"
  deployment_nodegroup      = "blue_green"
  capacity_type             = "ON_DEMAND"
  ami_type                  = "AL2_x86_64"
  instance_types            = "t2.medium"
  disk_size                 = "10"
  shared_owned              = "shared"
  enable_cluster_autoscaler = "true"
  tags = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}
```