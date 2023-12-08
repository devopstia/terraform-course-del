## MSQL resource
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance

## Connecting to a DB instance running the PostgreSQL database engine
```
https://www.hostinger.com/tutorials/how-to-install-postgresql-on-centos-7/
yum update -y
yum install postgresql-server postgresql-contrib
psql --version
```

## Ubuntu
```
apt update -y
sudo apt-get install postgresql-client
psql --version
```

## Connect through the CLI
- The default db in postgres is `postgres`
```
https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/
psql -h [HOSTNAME] -p [PORT] -U [USERNAME] -W -d [DATABASENAME]
psql -h s3-postgres.cv3uwkomseya.us-east-1.rds.amazonaws.com -p 5432 -U s3postgres -W -d s3

psql -h artifactory.devopseasylearning.net -p 5432 -U dbusername -W -d artifactory
```

```s
username                   = data.aws_secretsmanager_secret_version.rds_username.secret_string
password                   = data.aws_secretsmanager_secret_version.rds_password.secret_string


resource "aws_route53_record" "example" {
  zone_id = "Z09063052B43KCQ7FSGHY"
  name    = "s3db"
  type    = "CNAME"
  ttl     = "300"
  #   records = [aws_db_instance.alpha-db.endpoint]
  records = [split(":", aws_db_instance.alpha-db.endpoint)[0]]
}


variable "aws-secret-string" {
  type = set(string)
  default = [
    "db-password",
    "db-username"
  ]
}

resource "aws_secretsmanager_secret" "example" {
  for_each = var.aws-secret-string
  name     = each.key
  tags = {
    "Terraform" = "true"
    "Project"   = "MAM"
  }
}



# Get secret information for RDS password
data "aws_secretsmanager_secret" "rds_password" {
  name = "db-password"
}
data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = data.aws_secretsmanager_secret.rds_password.id
}

# Get secret information for RDS username
data "aws_secretsmanager_secret" "rds_username" {
  name = "db-username"
}
data "aws_secretsmanager_secret_version" "rds_username" {
  secret_id = data.aws_secretsmanager_secret.rds_username.id
}
```