## Terraform Workspace
```t
terraform workspace  new dev
terraform workspace  new prod

terraform workspace  select dev
terraform workspace  list
terraform workspace  show
terraform  init
terraform  plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
terraform destroy -var-file=dev.tfvars

terraform workspace  select prod
terraform workspace  list
terraform workspace  show
terraform  init
terraform  plan -var-file=prod.tfvars
terraform apply -var-file=prod.tfvars
terraform destroy -var-file=prod.tfvars

terraform workspace delete dev
```