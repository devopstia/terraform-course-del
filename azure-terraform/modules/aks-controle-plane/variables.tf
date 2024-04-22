
variable "location" {
  type    = string
  default = "Central US"
}

variable "tags" {
  type = map(any)
}

variable "version_prefix" {
  type = string
}

variable "log_analytics_retention_in_days" {
  type = string
}

variable "windows_admin_username" {
  type        = string
  default     = "azureuser"
  description = "This variable defines the Windows admin username k8s Worker nodes"
}

# variable "windows_admin_password" {
#   type        = string
#   default     = "DevOpsEasyLearning@102"
#   description = "This variable defines the Windows admin password k8s Worker nodes"
# }

