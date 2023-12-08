variable "common_tags" {
  type = map(any)
}

variable "postgres" {
  type = map(any)
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "AWS_ACCESS_KEY_ID" {
  type = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}
