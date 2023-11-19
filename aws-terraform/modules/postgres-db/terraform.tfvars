aws_region = "us-east-1"
vpc_id     = "vpc-068852590ea4b093b"
private_subnets = {
  us-east-1a = "subnet-096d45c28d9fb4c14"
  us-east-1b = "subnet-05f285a35173783b0"
  us-east-1c = "subnet-0fe3255479ad7c3a4"
}

postgres = {
  engine                      = "postgres"
  engine_version              = "13.4"
  instance_class              = "db.t3.small"
  allocated_storage           = 20
  max_allocated_storage       = 100
  publicly_accessible         = false
  db_name                     = "artifactory"
  final_snapshot_identifier   = "alpha-db-snapshot"
  skip_final_snapshot         = false
  backup_retention_period     = 7
  deletion_protection         = true
  maintenance_window          = "Sun:03:00-Sun:04:00"
  multi_az                    = false
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = true
  family                      = "postgres13"
  zone_id                     = "Z09063052B43KCQ7FSGHY"
  aws_route53_record          = "artifactory"

  rds_password_secretsmanager_secret_path = "2560-dev-del-artifactory-db-password"
  rds_username_secretsmanager_secret_path = "2560-dev-del-artifactory-db-username"
}

common_tags = {
  "id"             = "2560"
  "owner"          = "DevOps Easy Learning"
  "teams"          = "DEL"
  "environment"    = "dev"
  "project"        = "del"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}
