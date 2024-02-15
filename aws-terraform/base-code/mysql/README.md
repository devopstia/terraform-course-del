## MSQL resource
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance

## Connecting to a DB instance running the MySQL database engine
```
yum install mariadb
or
apt-get install mariadb-client

mysql --version
```

## Connect through the CLI
```
mysql -h [MYSQL Endpoint] -P 3306 -u [username] -p

mysql -h mysql–instance1.123456789012.us-east-1.rds.amazonaws.com -P 3306 -u admin -p

mysql -h terraform-20220913203917143600000001.cv3uwkomseya.us-east-1.rds.amazonaws.com -P 3306 -u admin -p

mysql -h [MYSQL Endpoint] -P 3306 -u admin -p
```