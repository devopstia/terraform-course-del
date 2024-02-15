## RDS + Aurora + MySQL + PostgreSQL + Bastion + Terraform
- https://medium.com/@jerome.decoster/rds-aurora-mysql-postgresql-bastion-terraform-17c5a76aced8

- https://www.reddit.com/r/Terraform/comments/qukv6f/terraform_aurora_postgresql_help_read_replica/ 

## Connecting to a DB instance running the PostgreSQL database engine
```
https://www.hostinger.com/tutorials/how-to-install-postgresql-on-centos-7/
yum update -y
yum install postgresql-server postgresql-contrib
psql --version

or
https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/
sudo apt-get update
sudo apt-get install postgresql-client -y
psql --version
```

## Connect through the CLI
- The default db in postgres is `postgres`

https://www.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/
```sh
psql -h [HOSTNAME] -p [PORT] -U [USERNAME] -W -d [DATABASENAME]
psql --host=example-cluster.cluster-cv3uwkomseya.us-east-1.rds.amazonaws.com --port=5432 --username=adminuser --password --dbname=postgres 

psql --host=example-cluster.cluster-ro-cv3uwkomseya.us-east-1.rds.amazonaws.com --port=5432 --username=adminuser --password --dbname=postgres 

psql --host=alpha-0.devopseasylearning.net --port=5432 --username=adminuser --password --dbname=postgres 
psql --host=alpha-1.devopseasylearning.net --port=5432 --username=adminuser --password --dbname=postgres

psql --host=artifactory.devopseasylearning.net --port=5432 --username=adminuser --password --dbname=artifactory
```