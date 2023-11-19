resource "aws_db_instance" "bamboo-db" {
  instance_class          = "db.t2.small" #1cpu and 2G of ram
  engine                  = "postgres"
  identifier              = "bamboo-cicd-db"
  engine_version          = "10.20"
  port                    = 5432
  multi_az                = false
  publicly_accessible     = false
  deletion_protection     = false
  storage_encrypted       = true
  storage_type            = "gp2"
  allocated_storage       = 20
  max_allocated_storage   = 50
  name                    = "bamboo"
  username                = "adminuser"
  password                = data.aws_ssm_parameter.bamboo-db-password.value
  apply_immediately       = "true"
  backup_retention_period = 0
  skip_final_snapshot     = true
  # backup_window           = "09:46-10:16"
  db_subnet_group_name   = aws_db_subnet_group.bamboo-postgres-db-subnet.name
  vpc_security_group_ids = ["${aws_security_group.bamboo-postgres-db-sg.id}"]

  tags = {
    Name = "postgres-bamboo-cicd-db"
  }
}


resource "aws_db_subnet_group" "bamboo-postgres-db-subnet" {
  name = "bamboo-postgres-db-subnet"
  subnet_ids = [
    "${data.aws_subnet.db-subnet-public-01.id}",
    "${data.aws_subnet.db-subnet-public-02.id}",
  ]
}

resource "aws_route53_record" "cluster-alias" {
  depends_on = [aws_db_instance.bamboo-db]
  zone_id    = "Z09063052B43KCQ7FSGHY"
  name       = "bamboo-rds"
  type       = "CNAME"
  ttl        = "60"

  records = [split(":", aws_db_instance.bamboo-db.endpoint)[0]]
  # https://github.com/hashicorp/terraform/issues/4996
  # records    = [aws_db_instance.bamboo-db.endpoint]
}

resource "aws_security_group" "bamboo-postgres-db-sg" {
  name   = "postgres-rds-sg"
  vpc_id = data.aws_vpc.bamboo_vpc.id
}

resource "aws_security_group_rule" "postgres-rds-sg-rule" {
  from_port         = 5432
  protocol          = "tcp"
  to_port           = 5432
  security_group_id = aws_security_group.bamboo-postgres-db-sg.id
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "outbound_rule" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.bamboo-postgres-db-sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

















