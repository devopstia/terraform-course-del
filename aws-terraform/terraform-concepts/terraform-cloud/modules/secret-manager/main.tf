# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret
resource "aws_secretsmanager_secret" "apha_db_username" {
  name = format("%s-%s-artifactory-db-username", var.common_tags["Environment"], var.common_tags["Project"])
}

resource "aws_secretsmanager_secret" "apha_db_password" {
  name = format("%s-%s-artifactory-db-password", var.common_tags["Environment"], var.common_tags["Project"])
}

