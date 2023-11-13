### Course GitHub Repository Links
- [Course Main Repository](https://github.com/stacksimplify/hashicorp-certified-terraform-associate-on-azure)

- [Terraform Cloud Demo](https://github.com/stacksimplify/terraform-cloud-azure-demo1)

- [Terraform Public Module Registry](https://github.com/stacksimplify/terraform-azurerm-staticwebsitepublic)

- [Terraform Private Module Registry](https://github.com/stacksimplify/terraform-azurerm-staticwebsiteprivate)

- [Terraform Sentinel Policies](https://github.com/stacksimplify/terraform-sentinel-policies-azure)

- [Course Presentation](https://github.com/stacksimplify/hashicorp-certified-terraform-associate-on-azure/tree/main/course-presentation)


### Free account
[Build in the cloud with an Azure free account](https://azure.microsoft.com/en-us/free/)

### Azure CLI installation on windows
[How to install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

1. Check the version
```
az --version
```
2. Help
```
az
```
3. Login through Azure cli
```
az login
```

## Lookup Function
lookup retrieves the value of a single element from a map, given its key. If the given key does not exist, the given default value is returned instead.
```t
> lookup({a="ay", b="bee"}, "a", "what?")
ay
> lookup({a="ay", b="bee"}, "b", "what?")
bee
# c is not given an that is why it return `what?`
> lookup({a="ay", b="bee"}, "c", "what?")
what?
```

```t
# Terraform lookup() Function with our map
lookup(map, key, default)

> lookup({"eastus"="Basic", "eastus2"="Standard"},"eastus", "Basic")
Basic
> lookup({"eastus"="Basic", "eastus2"="Standard"},"eastus2", "Basic")
Standard
> lookup({"eastus"="Basic", "eastus2"="Standard"},"eastus3", "Basic")
Basic
> lookup({"eastus"="Basic", "eastus2"="Standard"},"", "Basic")
Basic
```

```t
variable "public_ip_sku" {
  description = "Azure Public IP Address SKU"
  type = map(string)
  default = {
    "eastus" = "Basic",
    "eastus2" = "Standard"
  }
}

# Create Public IP Address
resource "azurerm_public_ip" "mypublicip" {
  name                = "mypublicip-1"
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  allocation_method   = "Static"
  domain_name_label = "app1-vm-${random_string.myrandom.id}"
  #sku = var.public_ip_sku["eastus"]
  #sku = var.public_ip_sku["eastus2"]
  sku = lookup(var.public_ip_sku, var.resoure_group_location, "Basic")
  tags = var.common_tags
}
```

## Element function

```t
>  element(["a", "b", "c"], 0)
a
>  element(["a", "b", "c"], 1)
b
>  element(["a", "b", "c"], 2)
c
>  element(["a", "b", "c"], 3)
a

> element(["a", "b", "c"], length(["a", "b", "c"])-0)
a
> element(["a", "b", "c"], length(["a", "b", "c"])-1)
c
> element(["a", "b", "c"], length(["a", "b", "c"])-2)
b

> length(["a", "b", "c"])
3
```

```t
variable "ec2_count" {
  type = number
  default = "3"
}
variable "subnets" {
   default = ["subnet-5d861027","subnet-e33e9baf","subnet-70713b19"]
}
variable "environment" {
  default = "dev"
}
variable "product" {
  default = "sales"
}

provider "aws" {
    region =   var.aws_region
    profile = var.profile
}

resource "aws_instance" "ec2" {
  ami           = var.ec2_ami
  instance_type = var.instance_type
  key_name = var.ec2_keypair
  count = var.ec2_count
  vpc_security_group_ids = ["${aws_security_group.ec2-sg.id}"]
  subnet_id = element(var.subnets, count.index)

  tags = {
    Name = "${var.environment}.${var.product}-${count.index+1}"
    # Name = "${var.environment}.${var.product}-${count.index+0}"
  }
}
dev-sales-1
dev-sales-2
dev-sales-3

dev-sales-0
dev-sales-1
dev-sales-2
```

```t
# Use case example
provider "azurerm" {
  features {}
}

locals {
  locations =["West Europe", "East US", "West US"]
}

resource "azurerm_resource_group" "example" {
  count    = 3
  name     = "example-resources"
  location = element(local.locations, count.index)
}

resource "azurerm_mariadb_server" "example" {
  count               = 6
  name                = "example-mariadb-server-${count.index + 1}"
#   name                = "example-mariadb-server-${count.index + 0}"
  location            = element(azurerm_resource_group.example, count.index).location
  resource_group_name = element(azurerm_resource_group.example, count.index).name

  administrator_login          = "mariadbadmin"
  administrator_login_password = "H@Sh1CoR3!"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "10.2"

  auto_grow_enabled             = true
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  public_network_access_enabled = false
  ssl_enforcement_enabled       = true
}

# 3 resource groups:
 # azurerm_resource_group.example[0] will be created
  + resource "azurerm_resource_group" "example" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "example-resources-1"
    }

  # azurerm_resource_group.example[1] will be created
  + resource "azurerm_resource_group" "example" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "example-resources-2"
    }

  # azurerm_resource_group.example[2] will be created
  + resource "azurerm_resource_group" "example" {
      + id       = (known after apply)
      + location = "westus"
      + name     = "example-resources-3"
    }

# 6 databases
 # azurerm_mariadb_server.example[0] will be created
  + resource "azurerm_mariadb_server" "example" {
      + location                      = "westeurope"
      + name                          = "example-mariadb-server-1"
    }

  # azurerm_mariadb_server.example[1] will be created
  + resource "azurerm_mariadb_server" "example" {
      + location                      = "eastus"
      + name                          = "example-mariadb-server-2"
    }

  # azurerm_mariadb_server.example[2] will be created
  + resource "azurerm_mariadb_server" "example" {
      + location                      = "westus"
      + name                          = "example-mariadb-server-3"
    }

  # azurerm_mariadb_server.example[3] will be created
  + resource "azurerm_mariadb_server" "example" {
      + location                      = "westeurope"
      + name                          = "example-mariadb-server-4"
    }

  # azurerm_mariadb_server.example[4] will be created
  + resource "azurerm_mariadb_server" "example" {
      + location                      = "eastus"
      + name                          = "example-mariadb-server-5"
    }

  # azurerm_mariadb_server.example[5] will be created
  + resource "azurerm_mariadb_server" "example" {
      + location                      = "westus"
      + name                          = "example-mariadb-server-6"
    }
```

## Test contains() function
```t
Template: contains(list, value)
contains(["a", "b", "c"], "a")
contains(["a", "b", "c"], "d")
contains(["eastus", "eastus2"], "westus2")

> contains(["a", "b", "c"], "a")
true
> contains(["a", "b", "c"], "b")
true
> contains(["a", "b", "c"], "c")
true
> contains(["a", "b", "c"], "d")
false

> contains(["eastus", "eastus2"], "westus2")
false
> contains(["eastus", "eastus2"], "eastus2")
true
> contains(["eastus", "eastus2"], "eastus")
true
```

## Create Resource Group Variable with Validation Rules
- Understand and implement custom validation rules in variables
- **condition:** Defines the expression used to evaluate the Input Variable value. Must return either `true for valid`, or `false for invalid value`.
- **error_message:** Defines the error message displayed by Terraform when the condition expression returns false for an invalid value. Must be ended with period or question mark 
- **c2-variables.tf**
```t
# Resource Group Location
variable "resoure_group_location" {
  description = "Resource Group Location"
  type = string
  default = "eastus"
  validation {
    condition  = var.resoure_group_location == "eastus" || var.resoure_group_location == "eastus2"
    error_message = "We only allow Resources to be created in eastus or eastus2 Locations."
  }  
}

# Observation
1. When `resoure_group_location = "eastus"`, terraform plan should pass
2. When `resoure_group_location = "eastus2"`, terraform plan should pass
3. When `resoure_group_location = "westus"`, terraform plan should fail with error message as validation rule failed. 

variable "resoure_group_location" {
  description = "Resource Group Location"
  type = string
  default = "eastus"
  validation {
    condition  = var.resoure_group_location == "eastus" 
    error_message = "We only allow Resources to be created in eastus Location."
  }  
}
```
## Validation rule with contains() function and comment previous one
```t
variable "resoure_group_location" {
  description = "Resource Group Location"
  type = string
  default = "eastus"
  validation {
    condition = contains(["eastus", "eastus2"], lower(var.resoure_group_location))
    error_message = "We only allow Resources to be created in eastus or eastus2 Locations."
  }  
}

# Observation
1. When `resoure_group_location = "eastus"`, terraform plan should pass
2. When `resoure_group_location = "eastus2"`, terraform plan should pass
3. When `resoure_group_location = "westus"`, terraform plan should fail with error message as validation rule failed. 

variable "resoure_group_location" {
  description = "Resource Group Location"
  type = string
  default = "eastus"
  validation {
    condition = contains(["eastus"], lower(var.resoure_group_location))
    error_message = "We only allow Resources to be created in eastus Location."
  }  
}
```

## Regex() function
```t
This check if india is append at the end of location

Template: regex(pattern, string)

### TRUE CASES
regex("india$", "westindia")
regex("india$", "southindia")
can(regex("india$", "westindia"))
can(regex("india$", "southindia"))

> regex("india$", "westindia")
india
> regex("india$", "southindia")
india
> can(regex("india$", "westindia"))
true
> can(regex("india$", "southindia"))
true

### FAILURE CASES
regex("india$", "eastus")
can(regex("india$", "eastus"))

> can(regex("india$", "eastus"))
false
```

```t
variable "resoure_group_location" {
  description = "Resource Group Location"
  type = string
  default = "eastus"
  validation {
    #condition  = var.resoure_group_location == "eastus" || var.resoure_group_location == "eastus2"
    #condition = contains(["eastus", "eastus2"], lower(var.resoure_group_location))
    #error_message = "We only allow Resources to be created in eastus or eastus2 Locations."
    condition = can(regex("india$", var.resoure_group_location))
    error_message = "We only allow Resources to be created in westindia and southindia locations."
  }  
}
```

## Protect Sensitive Input Variables
- [Vault Provider](https://learn.hashicorp.com/tutorials/terraform/secrets-vault?in=terraform/secrets)
- When using environment variables to set sensitive values, keep in mind that those values will be in your environment and command-line history
`Example: export TF_VAR_db_username=admin TF_VAR_db_password=adifferentpassword`
- When you use sensitive variables in your Terraform configuration, you can use them as you would any other variable. 
- Terraform will `redact` these values in command output and log files, and raise an error when it detects that they will be exposed in other ways.
- **Important Note-1:** Never check-in `secrets.tfvars` to git repositories
- **Important Note-2:** Terraform state file contains values for these sensitive variables `terraform.tfstate`. You must keep your state file secure to avoid exposing this data.

**NB:** use sensitive = true if you do not want the values to be printed when you run terraform plan
```t
# Database Secure Variables
db_username = "mydbadmin"
db_password = "H@Sh1CoR3!"

# Azure MySQL DB Username (Variable Type: Sensitive String)
variable "db_username" {
  description = "Azure MySQL Database Administrator Username"
  type        = string
  sensitive   = true
}

# Azure MySQL DB Password (Variable Type: Sensitive String)
variable "db_password" {
  description = "Azure MySQL Database Administrator Password"
  type        = string
  sensitive   = true
}

# Review the terraform plan
terraform plan -var-file="secrets.tfvars"
Observation:
1. Review the values for db_username and db_password in azurerm_mysql_server resource
2. You should see they were marked as sensitive

# Sample Output
  + resource "azurerm_mysql_server" "mysqlserver" {
      + administrator_login               = (sensitive)
      + administrator_login_password      = (sensitive value)


variable "db_username" {
  description = "Azure MySQL Database Administrator Username"
  type        = string
}

# Azure MySQL DB Password (Variable Type: Sensitive String)
variable "db_password" {
  description = "Azure MySQL Database Administrator Password"
  type        = string
}

# All password will be sensitive value by default
  + resource "azurerm_mysql_server" "mysqlserver" {
      + administrator_login               = "mydbadmin"
      + administrator_login_password      = (sensitive value)
```



## Conditional Expressions
- Learn [Terraform Conditional Expressions](https://www.terraform.io/docs/language/expressions/conditionals.html) in Terraform
- **Conditional Expression:** A conditional expression uses the value of a bool expression to select one of two values.

If condition is true then the result is `true_val`. If condition is false then the result is `false_val`.
```t
# Example-1
condition ? true_val : false_val
```

If `var.a` is an empty string then the result is "default-a", but otherwise it is the actual value of `var.a`.
```t
# Example-2
var.a != "" ? var.a : "default-a"
```

```t
# Virtual Network Address - Dev
variable "vnet_address_space_dev" {
  description = "Virtual Network Address Space for Dev Environment"
  type = list(string)
  default = ["10.0.0.0/16"]
}

variable "environment" {
  description = "Environment Name"
  type = string
  default = "dev"
}

# Virtual Network Address - 
variable "vnet_address_space_all" {
  description = "Virtual Network Address Space for All Environment except Dev"
  type = list(string)
  default = ["10.1.0.0/16", "10.2.0.0/16", "10.3.0.0/16"]
}


# With Equals (==)
  vnet_address_space = (var.environment == "dev" ? var.vnet_address_space_dev : var.vnet_address_space_all)
  # With Not Equals (!=)
  vnet_address_space = (var.environment != "dev" ? var.vnet_address_space_all : var.vnet_address_space_dev)
}
```
* Create allocated_storage only if snapshot_identifier is set to null, else, set allocated_storage to null
```t
variable "_rds_defaults" {
  description = "Default rds properties, if not overridden"
  type        = map(string)
  default = {
    snapshot_identifier         = null
    allocated_storage           = "250"
    max_allocated_storage       = "2" # multiplier for allocated_storage
  }
}
```

* Create max_allocated_storage only if snapshot_identifier is set to null. max_allocated_storage = allocated_storage x 2 = 250 x 2 = 500. else, set allocated_storage to null
```t
max_allocated_storage = local.rds["snapshot_identifier"] == null ? local.rds["allocated_storage"] * local.rds["max_allocated_storage"] : null


variable "_rds_defaults" {
  description = "Default rds properties, if not overridden"
  type        = map(string)
  default = {
    snapshot_identifier         = null
    allocated_storage           = "250"
    max_allocated_storage       = "2" # multiplier for allocated_storage
  }
}
```
* if default is set to null, do not create rds_password. if default is not set to null, create `1` rds_password because `count` is `1`. RDS PASSWORD will be created here because default is not set to `null` or equal `null`.
```t
count       = var.rds_password != null ? 1 : 0

variable "rds_password" {
  type        = string
  description = "Master DB password for RDS. Should not be placed in source code. Either use terraform.tfvars or enter when running Terraform."
  default     = "DefaultPassword!23"
}
```

* create isprod if t_environment is set to PRD. Else, do not create isprod. isprod will not be created because t_environment = "DEV". it will be create only if t_environment = "PRD"
```t
isprod              = local.tags["t_environment"] == "PRD" ? true : false

 tags = {
      environment   = "${local.common.environment}"
      t_environment = "DEV" # Must be one of the following values - DEV, DR, POC, PRD, PRF, QA, STG, TST. Pick the one that matches your environment the closest.
    }
```

* If the variable kms_arn is not set to `null`, create it. Else set it to `null` or do not create it. kms_arn will not be create because it is set to `null` already.
```t
kms_key_id  = var.kms_arn != null ? var.kms_arn : null

variable "panel_key" {
  type        = string
  default     = null
}
```
* tobool : it use to convert element init boolean. if boolean instance_start = true, execute local.bastion["instance_count"]. else, do nothing or false
```tf
bastion_instance_start = tobool(local.bastion["instance_start"]) == true ? local.bastion["instance_count"] : 0
```

* If condition is true then the result is `true_val`. If condition is false then the result is `false_val`.
```tf
condition ? true_val : false_val
```

* If `var.a` is an empty string then the result is `"default-a"`, but otherwise it is the actual value of `var.a.`
```tf
var.a != "" ? var.a : "default-a"
```

* Never use the `== or !=` operators to compare Boolean values, since these perform string comparisons, and cannot handle the multiple possible synonyms of true and false. For example, instead of:
```tf
var.x == true ? var.y : var.z
```
* simply use:
```tf
var.x ? var.y : var.z
```

```t
provider "aws" {
  region = "us-east-1"
}

variable "create_id" {
  default = true
}

resource "random_id" "id1" {
  # resource wil be created because 1 is true
  count = "${var.create_id ? "1" : "0"}"
  byte_length = 2
}

resource "random_id" "id2" {
# resource will not be created because 0 is is false
count = "${var.create_id ? "0" : "1"}"
  byte_length = 2
}
```

```t
# create 1  virtual network if var.environment. Else create 5 virtual networks
resource "azurerm_virtual_network" "myvnet2" {
  #count = 2
  count = var.environment == "dev" ? 1 : 5
  name                = "${var.business_unit}-${var.environment}-${var.virtual_network_name}-${count.index}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  tags = local.common_tags
}
```

## Terraform taint & untaint commands

- **terraform taint:** The `terraform taint` command manually marks a Terraform-managed resource as tainted, forcing it to be destroyed and recreated on the next apply.
- **terraform untaint:** 
  - The terraform untaint command manually unmarks a Terraform-managed resource as tainted, restoring it as the primary instance in the state. 
  - This reverses either a manual terraform taint or the result of provisioners failing on a resource.
  - This command will not modify infrastructure, but does modify the state file in order to unmark a resource as tainted.
```t
# List Resources from state
terraform state list

# Taint a Resource
terraform taint <RESOURCE_NAME_IN_TERRAFORM_LOCALLY>
terraform taint azurerm_virtual_network.myvnet-new

# Terraform Plan
terraform plan
Observation: 
Message: "-/+ destroy and then create replacement"
Plan: 1 to add, 0 to change, 1 to destroy.

# Untaint a Resource
terraform untaint <RESOURCE_NAME_IN_TERRAFORM_LOCALLY>
terraform untaint azurerm_virtual_network.myvnet-new

# Terraform Plan
terraform plan
Observation: 
Message: "No changes. Your infrastructure matches the configuration."
```

# Terraform Plan with -target
```t
# List Resources from state
terraform state list

terraform plan -target=azurerm_virtual_network.myvnet-new

Observation:
1) Message: "Plan: 0 to add, 1 to change, 0 to destroy"
2) It is updating Change-1 because we are targeting that resource "aws_instance.my-ec2-vm-new"
3) It is not touching the new resource which we are creating now "azurerm_virtual_network.myvent9". It will be in terraform configuration but not getting provisioned when we are using -target

# Terraform Apply
terraform apply -target=azurerm_virtual_network.myvnet-new
```

## Terraform Command apply refershonly
- This commands comes under **Terraform Inspecting State**
- Understanding `terraform apply -refresh-only` clears a lot of doubts in our mind and terraform state file and state feature
- The `terraform apply -refresh-only`command is used to reconcile the state Terraform knows about (via its state file) with the real-world infrastructure. 
- This can be used to detect any drift from the last-known state, and to update the state file.
- This does not modify infrastructure, but does modify the state file. If the state is changed, this may cause changes to occur during the next plan or apply.
- **terraform apply -refresh-only:** Update terraform.tfstate state file against real resources in cloud
- **Desired State:** Local Terraform Manifest (All *.tf files)
- **Current State:**  Real Resources present in your cloud