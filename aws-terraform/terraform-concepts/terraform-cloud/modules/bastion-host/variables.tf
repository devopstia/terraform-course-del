variable "aws_region" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type        = string
  description = " "
}

variable "key_name" {
  type        = string
  description = " "
}

variable "common_tags" {
  type = map(any)
}
