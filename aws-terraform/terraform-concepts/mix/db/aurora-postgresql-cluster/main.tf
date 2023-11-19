resource "aws_rds_cluster" "cluster" {
  engine                  = "aurora-postgresql"
  identifier              = "artifactory"
  engine_mode             = "provisioned"
  engine_version          = "13.4"
  cluster_identifier      = "aurora-db-artifact"
  master_username         = "username"
  master_password         = "somepass123"
  database_name           = "aurorapostgresql"
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = ["${aws_security_group.aurora-postgres-rds-sg.id}"]
  backup_retention_period = 7
  skip_final_snapshot     = true

  # availability_zones      = ["us-east-1a", "us-east-1b"]
  tags = {
    "CreateBy" = "Terraform"
    "Owner"    = "PECS"
  }
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  identifier          = "aurora-postgresql-${count.index}"
  count               = 2
  cluster_identifier  = aws_rds_cluster.cluster.id
  instance_class      = "db.t3.medium"
  engine              = "aurora-postgresql"
  engine_version      = "13.4"
  publicly_accessible = false

  tags = {
    "CreateBy" = "Terraform"
    "Owner"    = "PECS"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name = "aurora-postgresql-rds-db-subnet"
  subnet_ids = [
    "${data.aws_subnet.eks-db-subnet-01.id}",
    "${data.aws_subnet.eks-db-subnet-02.id}"
  ]
}


resource "aws_security_group" "aurora-postgres-rds-sg" {
  name   = "aurora-postgres-rds-sg"
  vpc_id = data.aws_vpc.adl_eks_vpc.id
}

resource "aws_security_group_rule" "aurora-postgres-rds-sg-rule" {
  from_port         = 5432
  protocol          = "tcp"
  security_group_id = aws_security_group.aurora-postgres-rds-sg.id
  to_port           = 5432
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "aurora-outbound_rule" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.aurora-postgres-rds-sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}
















