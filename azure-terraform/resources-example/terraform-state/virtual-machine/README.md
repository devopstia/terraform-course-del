## Authentication with Azure CLI
https://jeffbrown.tech/terraform-azure-authentication/

## Create SSH Keys for Azure Linux VM
```t
# Create Folder
mkdir ssh-keys

# Create SSH Key
cd ssh-ekys
ssh-keygen \
    -m PEM \
    -t rsa \
    -b 4096 \
    -C "azureuser@devopseasylearning" \
    -f learning-terraform-azure.pem 
Important Note: If you give passphrase during generation, during everytime you login to VM, you also need to provide passphrase.


# List Files
ls -lrt ssh-keys/

# Files Generated after above command 
Public Key: learning-terraform-azure.pem.pub -> Rename as learning-terraform-azure.pub
Private Key: learning-terraform-azure.pem

# upload the public key to azure or add the key while creating an instance
- a private key will be used to connect

# Permissions for Pem file
chmod 400 learning-terraform-azure.pem

# Connect to VM and Verify 
ssh -i ssh-keys/learning-terraform-azure.pem azureuser@<PUBLIC-IP>
``` 

## Backend information
```s
terraform {
  backend "azurerm" {
    resource_group_name   = azurerm_resource_group.rg.name
    storage_account_name   = azurerm_storage_account.sa.name
    container_name         = azurerm_storage_container.container.name
    key                    = "path/to/terraform.tfstate"  # Specify the desired path here
  }
}
```

```s
terraform {
  backend "azurerm" {
    resource_group_name  = "2560-dev-del-storage"
    storage_account_name = "terraformstorage0akrc"
    container_name       = "terraformsblock0akrc"
    key                  = "virtual-machine/terraform.tfstate"
  }
}
```

```s
# Terraform Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "2560-dev-del-storage"
    storage_account_name = "terraformstorage0akrc"
    container_name       = "terraformsblock0akrc"
    key                  = "resource-group-test/terraform.tfstate"
  }
}
```

## State can also be in AWS
```s
terraform {
  backend "s3" {
    bucket = "del-terraform-state"
    key    = "virtual-machine/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "del-terraform-state-lock"
  }
}
```