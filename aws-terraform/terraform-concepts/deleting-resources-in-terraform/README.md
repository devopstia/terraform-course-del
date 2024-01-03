## How to delete resources in terraform?

```t
terraform state list
terraform destroy --target=aws_iam_user.user1
terraform destroy --target=aws_iam_user.user1
terraform destroy --target=aws_iam_user.user3
```

```t
terraform state list
terraform state rm aws_iam_user.user1
terraform state rm aws_iam_user.user1
terraform state rm aws_iam_user.user3
```