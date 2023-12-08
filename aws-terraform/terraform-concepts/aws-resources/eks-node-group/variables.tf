variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "common_tags" {
  type = map(any)
  default = {
    "AssetID"       = "2526"
    "AssetName"     = "Insfrastructure"
    "Teams"         = "DEL"
    "Environment"   = "dev"
    "Project"       = "alpha"
    "CreateBy"      = "Terraform"
    "cloudProvider" = "aws"
  }
}

variable "desired_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "ec2_ssh_key" {
  type = string
}

variable "ami_type" {
  type = string
}

variable "capacity_type" {
  type = string
}

variable "disk_size" {
  type = number
}

variable "force_update_version" {
  type = string
}

variable "instance_types" {
  type = list(string)
}

variable "label_name" {
  type = string
}

variable "eks_version" {
  type = string
}
