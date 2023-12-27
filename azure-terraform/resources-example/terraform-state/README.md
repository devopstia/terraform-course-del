## State lock in AWS
- in AWS, we need s3 and DynamoDB to lock the state file 

## State lock in Azure
- Azure stoarge account support both state storage and state loking out of the box


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