# Define string variables
variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "us-east-1"
}

variable "ec2_instance_ami" {
  type        = string
  description = "AMI ID for the EC2 instance"
  default     = "ami-0fc5d935ebf8bc3bc"
}

variable "ec2_instance_type" {
  type        = string
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}

variable "ec2_instance_key_name" {
  type        = string
  description = "Name of the key pair for the EC2 instance"
  default     = "terraform-aws"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs for the EC2 instance"
  default     = ["sg-0c51540c60857b7ed"]
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the EC2 instance"
  default     = "subnet-096d45c28d9fb4c14"
}

variable "root_volume_size" {
  type        = number
  description = "Size of the root volume for the EC2 instance"
  default     = 10
}

variable "bucket_suffix_length" {
  type        = number
  description = "Length of the random string used in the S3 bucket name"
  default     = 8
}

variable "bucket_suffix_special" {
  type        = bool
  description = "Include special characters in the random string for the S3 bucket name"
  default     = false
}

variable "bucket_suffix_upper" {
  type        = bool
  description = "Include uppercase letters in the random string for the S3 bucket name"
  default     = false
}

variable "bucket_suffix_number" {
  type        = bool
  description = "Include numbers in the random string for the S3 bucket name"
  default     = false
}
