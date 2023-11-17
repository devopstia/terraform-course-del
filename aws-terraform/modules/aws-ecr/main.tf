resource "aws_ecr_repository" "ecr" {
  for_each = toset(var.ecr_repository_names)
  name     = each.key
}
