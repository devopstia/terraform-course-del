variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "enable_user_data" {
  description = "Set to true to enable user data, false to disable."
  default     = true
}

variable "use_custom_ami" {
  description = "Set to true to enable user data, false to disable."
  default     = false
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags to be applied to resources"
  default = {
    "Teams"         = "DEL"
    "environment"   = "dev"
    "project"       = "del"
    "createBy"      = "Terraform"
    "cloudProvider" = "aws"
  }
}

variable "image_id" {
  type = string
}

variable "key_name" {
  type = string
}
variable "min_size" {
  type = string
}

variable "max_size" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "volume_size" {
  type = string
}

variable "load_balancer_type" {
  type = string
}

variable "internal-elb" {
  type = string
}

variable "subdomain_name" {
  type = string
}

variable "private_subnets" {
  type = map(string)
}

variable "public_subnets" {
  type = map(string)
}

variable "vpc_id" {
  type = string
}

variable "domain" {
  type = string
}

variable "jenkins-role-name" {
  type    = string
  default = "jenkins-master-role"
}


