## Example
```
terraform plan -var aws_instance=1
terraform apply -var aws_instance=1
terraform plan -destroy -var aws_instance=1
terraform destroy -var aws_instance=1

terraform plan -var-file="random.tfvars"
terraform apply -var-file="random.tfvars"
terraform plan -destroy -var-file="random.tfvars"
terraform destroy -var-file="random.tfvars"

terraform apply -var-file=prod.tfvars
terraform plan -destroy -var-file=prod.tfvars --target aws_iam_user.user1
terraform plan -var-file=prod.tfvars --target aws_iam_user.user1
terraform apply -var-file=prod.tfvars --target aws_iam_user.user1
```