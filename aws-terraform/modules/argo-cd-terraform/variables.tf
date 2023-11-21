variable "aws_region" {
  type    = string
  default = "us-east-1"
}

# variable "eks-control-plane-name" {
#   type    = string
#   default = "2560-dev-del"
# }

variable "env" {
  default = "staging"
}
