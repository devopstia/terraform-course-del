terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "employees" {
  type = map(string)
  default = {
    alice   = "engineer"
    bob     = "manager"
    charlie = "designer"
  }
}

output "contains_bob" {
  value = contains(keys(var.employees), "bob")
}

output "contains_manager" {
  value = contains(keys(var.employees), "manager")
}

output "contains_designer" {
  value = contains(keys(var.employees), "designer")
}

output "contains_hr" {
  value = contains(keys(var.employees), "hr")
}

output "contains_lead" {
  value = contains(keys(var.employees), "lead")
}
