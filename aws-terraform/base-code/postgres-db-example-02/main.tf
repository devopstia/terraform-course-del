resource "aws_db_instance" "postgres" {
  identifier            = "example-postgres-db" #good
  engine                = "postgres"            #good
  engine_version        = "13.4"                #good
  instance_class        = "db.t3.small"         #good
  allocated_storage     = 20                    #good
  max_allocated_storage = 100                   #good 
  publicly_accessible   = false                 #good
  name                  = "artifactory"         #good
  username              = "exampleuser"         #good
  password              = "examplepassword"     #good
  # The value must begin with a letter, only contain alphanumeric characters and hyphens, and not end with a hyphen or contain two consecutive hyphens
  final_snapshot_identifier = "alpha-db-snapshot" #good
  skip_final_snapshot       = false
  parameter_group_name      = aws_db_parameter_group.postgres.name
  backup_retention_period   = 7     #good 
  deletion_protection       = false #good
  #   maintenance_window          = "Sun:03:00-Sun:04:00"
  multi_az                    = false #good
  allow_major_version_upgrade = false #good
  auto_minor_version_upgrade  = true  #good

  vpc_security_group_ids = [aws_security_group.postgres.id]
  db_subnet_group_name   = aws_db_subnet_group.postgres.name

  tags = {
    Name = "example-postgres-db"
  }
}

resource "aws_security_group" "postgres" {
  name_prefix = "example-postgres-db-"
  vpc_id      = "vpc-0a94db89344c16694"
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
  name       = "example-postgres-subnet"
  subnet_ids = ["subnet-05c509b68d1fc7670", "subnet-0ff4a3ec38134f0d4"] # Replace with your own subnet IDs
}

resource "aws_db_parameter_group" "postgres" {
  name   = "default-postgres12"
  family = "postgres13"
}

resource "aws_route53_record" "example" {
  depends_on = [aws_db_instance.postgres]
  zone_id    = "Z09063052B43KCQ7FSGHY"
  name       = "artifactory"
  type       = "CNAME"
  ttl        = "30"
  #   records = [aws_db_instance.alpha-db.endpoint]
  records = [split(":", aws_db_instance.postgres.endpoint)[0]]
}