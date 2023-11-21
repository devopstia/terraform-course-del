variable "namespace" {
  type    = string
  default = "argo-cd"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "control_plane_name" {
  type    = string
  default = "2560-dev-del"
}
