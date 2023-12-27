location                        = "eastus"
disk_size_gb                    = "30"
size                            = "Standard_D4s_v3"
vm-number                       = 1
computer_name                   = "server"
vm-password                     = "Password@1234"
rootuser_name                   = "azureuser"
storage_account_type            = "Standard_LRS"
disable_password_authentication = false
tags = {
  "id"             = "2560"
  "owner"          = "DevOps Easy Learning"
  "teams"          = "DEL"
  "environment"    = "dev"
  "project"        = "del"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}