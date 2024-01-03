## Terraform state commands 

```t
terraform state list
terraform state rm aws_iam_user.user2
terraform state show aws_iam_user.user2
terraform state pull
terraform state push terraform.tfstate
terraform state pull > state
terraform state pull > terraform.tfstate
terraform force-unlock LOCK_ID 
```


```t
terraform taint [resource_name]
terraform taint aws_iam_user.user2

terraform untaint [resource_name]
terraform untaint aws_security_group.allow_all
```
