## Connecting to a DB instance running the PostgreSQL database engine
```
sudo apt install mysql-client -y
mysql --version
```

## Connect through the CLI
mysql -h <cluster_endpoint> -u <master_username> -p <database_name>
mysql -h example-cluster.cluster-abcdefg123456.us-east-1.rds.amazonaws.com -u adminuser -p my_database

mysql -h artifactory.devopseasylearning.net -u adminuser -p artifactory
```



