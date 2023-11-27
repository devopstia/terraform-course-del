locals {
  aws_region        = lookup(yamldecode(file("${path.module}/variable.yaml"))["configiration"], "aws_region", {})
  aws_instance_dev  = lookup(yamldecode(file("${path.module}/variable.yaml"))["configiration"]["dev"], "aws_instance", {})
  aws_instance_prod = lookup(yamldecode(file("${path.module}/variable.yaml"))["configiration"]["prod"], "aws_instance", {})
}
