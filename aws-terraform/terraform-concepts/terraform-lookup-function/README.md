
## variables
```s
variable "vm" {
  type = map(string)
  default = {
    region                 = "us-east-1"
    availability_zones     = ""
    instance_types         = ""
    subnet_id              = "subnet-096d45c28d9fb4c14"
    ami                    = "ami-0fc5d935ebf8bc3bc"
    vpc_security_group_ids = "sg-0c51540c60857b7ed"
    key_name               = "terraform-aws"
    volume_size            = "10"
  }
}
```
```s
# Print the "region" value
lookup(var.vm, "region")

# Print the "availability_zones" value
lookup(var.vm, "availability_zones")

# Print the "instance_types" value
lookup(var.vm, "instance_types")

# Print the "subnet_id" value
lookup(var.vm, "subnet_id")

# Print the "ami" value
lookup(var.vm, "ami")

# Print the "vpc_security_group_ids" value
lookup(var.vm, "vpc_security_group_ids")

# Print the "key_name" value
lookup(var.vm, "key_name")

# Print the "volume_size" value
lookup(var.vm, "volume_size")
```



## Variable
```s
variable "postgres" {
  type = map(any)
  default = {
    aws_region                  = "us-east-1"
    identifier                  = "example-postgres-db"
    engine                      = "postgres"
    engine_version              = "13.4"
    instance_class              = "db.t3.small"
    allocated_storage           = 20
    max_allocated_storage       = 100
    publicly_accessible         = false
    name                        = "artifactory"
    skip_final_snapshot         = true
    backup_retention_period     = 7
    deletion_protection         = false
    maintenance_window          = "Sun:03:00-Sun:04:00"
    multi_az                    = false
    allow_major_version_upgrade = false
    auto_minor_version_upgrade  = true
    family                      = "postgres13"
    zone_id                     = "Z09063052B43KCQ7FSGHY"
    route53-record              = "artifactory"
  }
}

variable "common_tags" {
  type = map(any)
  default = {
    "AssetID"       = "2560"
    "AssetName"     = "Insfrastructure"
    "Teams"         = "DEL"
    "Environment"   = "dev"
    "Project"       = "alpha"
    "CreateBy"      = "Terraform"
    "cloudProvider" = "aws"
  }
}
```

## Code
```s
resource "aws_db_instance" "alpha-db" {
  identifier                  = format("%s-%s-artifactory-db", var.common_tags["Environment"], var.common_tags["Project"])
  engine                      = lookup(var.postgres, "engine")
  engine_version              = lookup(var.postgres, "engine_version")
  instance_class              = lookup(var.postgres, "instance_class")
  allocated_storage           = lookup(var.postgres, "allocated_storage")
  max_allocated_storage       = lookup(var.postgres, "max_allocated_storage")
  publicly_accessible         = lookup(var.postgres, "publicly_accessible")
  name                        = format("%s", var.common_tags["Project"])
  username                    = data.aws_secretsmanager_secret_version.rds_username.secret_string
  password                    = data.aws_secretsmanager_secret_version.rds_password.secret_string
  skip_final_snapshot         = lookup(var.postgres, "skip_final_snapshot")
  parameter_group_name        = aws_db_parameter_group.postgres.name
  backup_retention_period     = lookup(var.postgres, "backup_retention_period")
  deletion_protection         = lookup(var.postgres, "deletion_protection")
  maintenance_window          = lookup(var.postgres, "maintenance_window")
  multi_az                    = lookup(var.postgres, "multi_az")
  allow_major_version_upgrade = lookup(var.postgres, "allow_major_version_upgrade")
  auto_minor_version_upgrade  = lookup(var.postgres, "auto_minor_version_upgrade")
  vpc_security_group_ids      = [aws_security_group.postgres.id]
  db_subnet_group_name        = aws_db_subnet_group.postgres.name

  ## This is to restore from snapshot
  snapshot_identifier = data.aws_db_snapshot.example_snapshot.id

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-artifactory-db", var.common_tags["AssetID"], var.common_tags["Environment"], var.common_tags["Project"])
    },
  )
}
```