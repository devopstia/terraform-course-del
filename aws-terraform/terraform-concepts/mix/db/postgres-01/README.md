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
psql --host=mypostgresql.c6c8mwvfdgv0.us-west-2.rds.amazonaws.com --port=5432 --username=awsuser --password --dbname=mypgdb 

psql --host=terraform-20220913213636696400000001.cv3uwkomseya.us-east-1.rds.amazonaws.com --port=5432 --username=adminuser --password --dbname=postgres 
```