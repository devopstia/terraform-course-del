variable "aws_region" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "subject_alternative_names" {
  type = string
}

variable "tags" {
  type = map(any)
}
