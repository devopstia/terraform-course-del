resource "aws_ssm_parameter" "example" {
  for_each  = toset(var.aws-param-values)
  name      = "/${var.tags["id"]}/${var.tags["environment"]}/${var.tags["project"]}/${each.value}"
  type      = "SecureString"
  value     = each.value
  overwrite = false
  tags      = var.tags
}


