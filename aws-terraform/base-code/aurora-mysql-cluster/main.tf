resource "aws_security_group" "rds_sg" {
  vpc_id = "vpc-068852590ea4b093b"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "subnet-group"
  subnet_ids = ["subnet-096d45c28d9fb4c14", "subnet-05f285a35173783b0"]
}

resource "aws_rds_cluster_parameter_group" "cluster_parameter_group" {
  name        = "cluster-parameter-group"
  family      = "aurora-mysql5.7"
  description = "Cluster parameter group"
}

resource "aws_rds_cluster" "aurora-cluster" {
  cluster_identifier              = "artifactory-aurora-mysql-cluster"
  engine                          = "aurora-mysql"
  engine_version                  = "5.7.mysql_aurora.2.07.10"
  master_username                 = "adminuser"
  master_password                 = "password"
  database_name                   = "artifactory"
  db_subnet_group_name            = aws_db_subnet_group.subnet_group.name
  vpc_security_group_ids          = [aws_security_group.rds_sg.id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.cluster_parameter_group.name
  skip_final_snapshot             = true # Set to false if you want to take a final snapshot when deleting the cluster

  storage_encrypted       = true
  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"
  deletion_protection     = false
  lifecycle {
    ignore_changes = [
      engine_version
    ]
  }
  tags = {
    Name = "artifactory-aurora-mysql-cluster"
  }
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                = 2
  cluster_identifier   = aws_rds_cluster.aurora-cluster.id
  instance_class       = "db.r5.large"
  engine               = "aurora-mysql"
  engine_version       = "5.7.mysql_aurora.2.07.10"
  publicly_accessible  = true
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  identifier           = "artifactory-${count.index + 1}"
  lifecycle {
    ignore_changes = [
      engine_version
    ]
  }
  tags = {
    Name = "artifactory-${count.index + 1}"
  }
}

resource "aws_route53_record" "cluster-alias" {
  zone_id = "Z09063052B43KCQ7FSGHY"
  name    = "artifactory"
  type    = "CNAME"
  ttl     = "30"
  records = [aws_rds_cluster.aurora-cluster.endpoint]
}