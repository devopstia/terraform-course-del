# locals {
#   aws_instance_dev  = lookup(yamldecode(file("./variable.yaml"))["dev"], "aws_instance", {})
#   aws_instance_prod = lookup(yamldecode(file("./variable.yaml"))["prod"], "aws_instance", {})
# }
# # OR
locals {
  aws_instance_dev  = lookup(yamldecode(file("${path.module}/variable.yaml"))["dev"], "aws_instance", {})
  aws_instance_prod = lookup(yamldecode(file("${path.module}/variable.yaml"))["prod"], "aws_instance", {})
}


