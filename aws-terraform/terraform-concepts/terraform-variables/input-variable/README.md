## input-variable
```t
terraform plan -var aws_instance=1
terraform apply -var aws_instance=1
terraform plan -destroy -var aws_instance=1
terraform destroy -var aws_instance=1
```


**In this example:** 
- We have a variable file which is not terraform.tfvars neither *.auto.tfvars file
- We will pass this variable file at run time as input
- This file will not load automatically because is not terraform.tfvars neither *.auto.tfvars file

```t
terraform plan -var-file="random.tfvars"
terraform apply -var-file="random.tfvars"
terraform plan -destroy -var-file="random.tfvars"
terraform destroy -var-file="random.tfvars"
```