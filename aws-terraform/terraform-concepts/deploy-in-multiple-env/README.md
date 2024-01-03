## Terraform deploying in multiple regions or environments

## Configure your config file
```t
[default]
region = us-west-2
output = json

[profile dev]
region = us-west-2
output = json

[profile qa]
region = us-west-2
output = json

[profile stg]
region = us-west-2
output = json

[profile prod]
region = us-east-1
output = json
```

## Configure your credential file
```t
[default]
aws_access_key_id = 
aws_secret_access_key = 

[dev]
aws_access_key_id = 
aws_secret_access_key = 

[prod]
aws_access_key_id = 
aws_secret_access_key =  

[stg]
aws_access_key_id = 
aws_secret_access_key = 

[qa]
aws_access_key_id = 
aws_secret_access_key = 
```

```t
aws s3 ls
aws s3 ls --profile dev
aws s3 ls --profile prod
aws s3 ls --profile qa
aws s3 ls --profile stg
AWS_PROFILE=dev aws s3 ls 
AWS_PROFILE=prod aws s3 ls 
AWS_PROFILE=qa aws s3 ls 
AWS_PROFILE=stg aws s3 ls 


AWS_PROFILE=default terraform plan
AWS_PROFILE=dev terraform plan 
AWS_PROFILE=prod terraform plan 
AWS_PROFILE=qa terraform plan AWS_PROFILE=stg terraform plan 


AWS_PROFILE=default terraform apply
AWS_PROFILE=dev terraform apply
AWS_PROFILE=prod terraform apply
AWS_PROFILE=qa terraform apply
AWS_PROFILE=stg terraform apply


AWS_PROFILE=default terraform destroy
AWS_PROFILE=dev terraform destroy
AWS_PROFILE=prod terraform destroy
AWS_PROFILE=qa terraform destroy
AWS_PROFILE=stg terraform destroy
```

```s
export AWS_PROFILE=default
echo $AWS_PROFILE

terraform plan
terraform apply
terraform destroy
```

```s
export AWS_PROFILE=qa
echo $AWS_PROFILE

terraform plan
terraform apply
terraform destroy
```

```s
export AWS_PROFILE=stg
echo $AWS_PROFILE

terraform plan
terraform apply
terraform destroy
```

```s
export AWS_PROFILE=prod
echo $AWS_PROFILE

terraform plan
terraform apply
terraform destroy
```