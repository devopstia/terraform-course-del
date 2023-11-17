# variable "aws_region" {
#   type    = string
#   default = "us-east-2"
# }


variable "release" {
  description = "The Ubuntu release to use, YY-MM format."
  type        = string
  # default     = "22.04"
}
