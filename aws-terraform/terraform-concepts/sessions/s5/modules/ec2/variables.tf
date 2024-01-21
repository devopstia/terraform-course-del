variable "tags" {
  type = map(any)
  #   default = {
  #     "id"             = "2560"
  #     "owner"          = "DevOps Easy Learning"
  #     "teams"          = "DEL"
  #     "environment"    = "development"
  #     "project"        = "s5"
  #     "create_by"      = "Terraform"
  #     "cloud_provider" = "aws"
  #   }
}

variable "aws_region" {
  type = string
  #   default = "us-east-1"
}

variable "instance_name" {
  type = string
}

variable "instance_params" {
  type = any
  #   default = {
  #     instance_type          = "t2.micro"
  #     key_name               = "terraform-aws"
  #     vpc_security_group_ids = "sg-0c51540c60857b7ed"
  #     subnet_id              = "subnet-096d45c28d9fb4c14"
  #     volume_size            = "10"
  #   }
}