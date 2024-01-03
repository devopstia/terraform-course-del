## Terraform commands | Terraform apply and destroy with target

```t
terraform plan -destroy --target aws_iam_user.user1
terraform destroy --target aws_iam_user.user1
terraform plan --target aws_iam_user.user1
terraform apply --target aws_iam_user.user1
```

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

