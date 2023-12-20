variable "location" {
  type    = string
  default = "eastus"
}

variable "disk_size_gb" {
  type    = string
  default = "8"
}

variable "size" {
  type    = string
  default = "Standard_D4s_v3"
}

variable "computer_name" {
  type    = string
  default = "Test"
}

variable "vm-password" {
  type    = string
  default = "Password@1234"
}

variable "rootuser_name" {
  type    = string
  default = "azureuser"
}

variable "disable_password_authentication" {
  type = bool
}

variable "storage_account_type" {
  type = string
}
variable "tags" {
  type = map(any)
  default = {
    "id"             = "2560"
    "owner"          = "DevOps Easy Learning"
    "teams"          = "DEL"
    "environment"    = "dev"
    "project"        = "del"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
}