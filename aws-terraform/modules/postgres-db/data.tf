
# Get secret information for RDS password
data "aws_secretsmanager_secret" "rds_password" {
  name = lookup(var.postgres, "rds_password_secretsmanager_secret_path")
}
data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = data.aws_secretsmanager_secret.rds_password.id
}

# Get secret information for RDS username
data "aws_secretsmanager_secret" "rds_username" {
  name = lookup(var.postgres, "rds_username_secretsmanager_secret_path")
}
data "aws_secretsmanager_secret_version" "rds_username" {
  secret_id = data.aws_secretsmanager_secret.rds_username.id
}
