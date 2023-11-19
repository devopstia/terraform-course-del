## MSQL resource
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance

## Connecting to a DB instance running the PostgreSQL database engine
```
https://www.hostinger.com/tutorials/how-to-install-postgresql-on-centos-7/
yum update -y
yum install postgresql-server postgresql-contrib
psql --version

or
https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/
sudo apt-get update
sudo apt-get install postgresql-client

psql --version
```

## Connect through the CLI
- The default db in postgres is `postgres`

https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/
```
psql -h [HOSTNAME] -p [PORT] -U [USERNAME] -W -d [DATABASENAME]

psql --host=bamboo-cicd-db.cv3uwkomseya.us-east-1.rds.amazonaws.com --port=5432 --username=adminuser --password --dbname=bamboo 

nslookup bamboo-rds.devopseasylearning.net
psql --host=bamboo-rds.devopseasylearning.net --port=5432 --username=adminuser --password --dbname=bamboo 
```

## RDS exported attribute 'endpoint' should not include port number
- https://github.com/hashicorp/terraform/issues/4996
- This will add a port at the end of the enpoint and nslookup will failed
```
nslookup bamboo-cicd-db.cv3uwkomseya.us-east-1.rds.amazonaws.com:5432
```

```s
resource "aws_route53_record" "cluster-alias" {
  depends_on = [aws_db_instance.bamboo-db]
  zone_id    = "Z09063052B43KCQ7FSGHY"
  name       = "bamboo-rds"
  type       = "CNAME"
  ttl        = "60"
  records    = [aws_db_instance.bamboo-db.endpoint]
}
```

## We need to use the split function to word arround that
```s
resource "aws_route53_record" "cluster-alias" {
  depends_on = [aws_db_instance.bamboo-db]
  zone_id    = "Z09063052B43KCQ7FSGHY"
  name       = "bamboo-rds"
  type       = "CNAME"
  ttl        = "60"

  records = [split(":", aws_db_instance.bamboo-db.endpoint)[0]]
  # records    = [aws_db_instance.bamboo-db.endpoint]
}
```

```
nslookup bamboo-cicd-db.cv3uwkomseya.us-east-1.rds.amazonaws.com
```