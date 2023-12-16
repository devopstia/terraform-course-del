variable "resource_type" {
  type    = string
  default = "instance"
}

variable "resource_name" {
  type    = string
  default = "my-instance"
}

output "resource_id" {
  value = join("_", [var.resource_type, var.resource_name])
}
