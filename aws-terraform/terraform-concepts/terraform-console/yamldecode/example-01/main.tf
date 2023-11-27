# locals {
#   aws_instance = lookup(yamldecode(file("./variable.yaml"))["dev"], "aws_instance", {})
#   common_tags  = lookup(yamldecode(file("./variable.yaml"))["dev"]["aws_instance"], "tags", {})
# }
# # OR
locals {
  aws_instance = lookup(yamldecode(file("${path.module}/variable.yaml"))["dev"], "aws_instance", {})
  common_tags  = lookup(yamldecode(file("${path.module}/variable.yaml"))["dev"]["aws_instance"], "tags", {})
}


