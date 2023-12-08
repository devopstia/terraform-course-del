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

```