resource "aws_db_instance" "postgres" {
  identifier            = format("%s-%s-artifactory-db", var.common_tags["environment"], var.common_tags["project"])
  engine                = lookup(var.postgres, "engine")
  engine_version        = lookup(var.postgres, "engine_version")
  instance_class        = lookup(var.postgres, "instance_class")
  allocated_storage     = lookup(var.postgres, "allocated_storage")
  max_allocated_storage = lookup(var.postgres, "max_allocated_storage")
  publicly_accessible   = lookup(var.postgres, "publicly_accessible")
  db_name               = lookup(var.postgres, "db_name")
  # username                    = data.aws_secretsmanager_secret_version.rds_username.secret_string
  username                    = "artifactorydb"
  password                    = data.aws_secretsmanager_secret_version.rds_password.secret_string
  final_snapshot_identifier   = format("%s%sArtifactorySnapshot", var.common_tags["project"], var.common_tags["environment"])
  skip_final_snapshot         = lookup(var.postgres, "skip_final_snapshot")
  parameter_group_name        = aws_db_parameter_group.postgres.name
  backup_retention_period     = lookup(var.postgres, "backup_retention_period")
  deletion_protection         = lookup(var.postgres, "deletion_protection")
  maintenance_window          = lookup(var.postgres, "maintenance_window")
  multi_az                    = lookup(var.postgres, "multi_az")
  allow_major_version_upgrade = lookup(var.postgres, "allow_major_version_upgrade")
  auto_minor_version_upgrade  = lookup(var.postgres, "auto_minor_version_upgrade")

  vpc_security_group_ids = [aws_security_group.postgres.id]
  db_subnet_group_name   = aws_db_subnet_group.postgres.name

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-artifactory-db", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    },
  )
}

resource "aws_security_group" "postgres" {
  name_prefix = format("%s-%s-%s-artifactory-db-sg", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "postgres_ingress" {
  type        = "ingress"
  from_port   = 5432
  to_port     = 5432
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.postgres.id
}

resource "aws_security_group_rule" "postgres_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.postgres.id
}

resource "aws_db_subnet_group" "postgres" {
  name       = format("%s-%s-subnet-group", var.common_tags["environment"], var.common_tags["project"])
  subnet_ids = values(var.private_subnets)
}

resource "aws_db_parameter_group" "postgres" {
  family = lookup(var.postgres, "family")
}

resource "aws_route53_record" "example" {
  depends_on = [aws_db_instance.postgres]
  zone_id    = lookup(var.postgres, "zone_id")
  name       = lookup(var.postgres, "aws_route53_record")
  type       = "CNAME"
  ttl        = "300"
  records    = [local.endpoint_without_port]
}

locals {
  rds_endpoint          = aws_db_instance.postgres.endpoint
  endpoint_without_port = replace(local.rds_endpoint, ":5432", "")
}
