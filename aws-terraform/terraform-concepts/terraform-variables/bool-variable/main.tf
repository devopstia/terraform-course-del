# Define variables
variable "ec2_instance_ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0fc5d935ebf8bc3bc" # Replace with your desired AMI ID
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro" # Replace with your desired instance type
}

variable "ec2_instance_key_name" {
  description = "Key pair name for the EC2 instance"
  type        = string
  default     = "terraform-aws" # Replace with your desired key pair name
}

variable "security_group_ids" {
  description = "List of security group IDs for the EC2 instance"
  type        = list(string)
  default     = ["sg-0c51540c60857b7ed"] # Replace with your security group IDs
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance"
  type        = string
  default     = "subnet-096d45c28d9fb4c14" # Replace with your subnet ID
}

variable "root_volume_size" {
  description = "Size of the root volume for the EC2 instance"
  type        = number
  default     = 10 # Replace with your desired root volume size
}

variable "bucket_suffix_length" {
  description = "Length of the random bucket suffix"
  type        = number
  default     = 8 # Replace with your desired length
}

variable "bucket_suffix_special" {
  description = "Include special characters in the random bucket suffix"
  type        = bool
  default     = false # Set to true if you want special characters
}

variable "bucket_suffix_upper" {
  description = "Include uppercase letters in the random bucket suffix"
  type        = bool
  default     = true # Set to false if you don't want uppercase letters
}

variable "bucket_suffix_number" {
  description = "Include numbers in the random bucket suffix"
  type        = bool
  default     = true # Set to false if you don't want numbers
}

# EC2 instance resource
resource "aws_instance" "vm" {
  ami                    = var.ec2_instance_ami
  instance_type          = var.ec2_instance_type
  key_name               = var.ec2_instance_key_name
  vpc_security_group_ids = var.security_group_ids
  subnet_id              = var.subnet_id

  root_block_device {
    volume_size = var.root_volume_size
  }

  tags = {
    Name      = "vm"
    Create_By = "Terraform"
  }
}

# Random string resource
resource "random_string" "bucket_suffix" {
  length  = var.bucket_suffix_length
  special = var.bucket_suffix_special
  upper   = var.bucket_suffix_upper
  number  = var.bucket_suffix_number
}

# S3 bucket resource
resource "aws_s3_bucket" "example_bucket" {
  bucket = "my-unique-bucket-${random_string.bucket_suffix.result}"

  tags = {
    Name      = "my-unique-bucket-${random_string.bucket_suffix.result}"
    Create_By = "Terraform"
  }
}
