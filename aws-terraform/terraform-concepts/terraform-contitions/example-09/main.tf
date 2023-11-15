variable "create_rds_instance" {
  description = "Set to true to create the RDS instance, false to skip creation."
  type        = bool
  default     = false
}

variable "region" {
  description = "The AWS region for the RDS instance."
  type        = string
  default     = "us-east-1"
}

resource "aws_db_instance" "example" {
  count = var.create_rds_instance && (var.region == "us-east-1" || var.region == "us-west-1") ? 1 : 0

  allocated_storage   = 20
  storage_type        = "gp2"
  engine              = "mysql"
  engine_version      = "5.7"
  instance_class      = "db.t2.micro"
  name                = "mydb"
  username            = "admin"
  password            = "secretpassword"
  skip_final_snapshot = true

  tags = {
    Name = "mydb"
  }
}
