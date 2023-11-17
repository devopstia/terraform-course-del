## Create parameter manually
- Paremeter store require a default and it connot be set througth the console because terraform will either overwrite or failed if overwrite is set to false
- It is a good idea to create parameters manually through the connsle or aws CLI
- And Refer those in terraform code

## Create parameters
```
aws ssm put-parameter --name "/2560/dev/del/mysql-db-password" --value "admin" --type "SecureString" --overwrite
aws ssm put-parameter --name "/2560/dev/del/mysql-aurora-db-username" --value "admin" --type "SecureString" --overwrite
aws ssm put-parameter --name "/2560/dev/del/mysql-db-username" --value "admin" --type "SecureString" --overwrite
aws ssm put-parameter --name "/2560/dev/del/postges-aurora-username" --value "admin" --type "SecureString" --overwrite
aws ssm put-parameter --name "/2560/dev/del/postgres-db-username" --value "admin" --type "SecureString" --overwrite
```
## Use it to create a DB
```s
data "aws_ssm_parameter" "mysql-aurora-db-username" {
  name = "/2560/dev/del/mysql-aurora-db-username"
}

data "aws_ssm_parameter" "mysql-db-username" {
  name = "/2560/dev/del/mysql-db-username"
}

data "aws_ssm_parameter" "postges-aurora-username" {
  name = "/2560/dev/del/postges-aurora-username"
}

data "aws_ssm_parameter" "postgres-db-username" {
  name = "/2560/dev/del/postgres-db-username"
}

data "aws_ssm_parameter" "mysql-db-password" {
  name = "/2560/dev/del/mysql-db-password"
}

# Define your database resource here, and use the parameter values
resource "aws_db_instance" "example" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = data.aws_ssm_parameter.mysql-db-username.value # Retrieve the MySQL DB username
  password             = data.aws_ssm_parameter.mysql-db-password.value # Retrieve the MySQL DB password
  # Other database configuration options...
}
```