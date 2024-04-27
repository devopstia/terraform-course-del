
# locals {
#   aks_controle_name = format("%s-%s-%s", var.tags["id"], var.tags["environment"], var.tags["project"])
# }

variable "aks_control_plane_name" {
  type    = string
  default = "2560-dev-del"
}

variable "aks_rg" {
  type    = string
  default = "2560-dev-del-rg"
}

variable "tags" {
  type = map(any)
}

variable "subscription_id" {
  type    = string
  default = "c344bf80-ed9d-4630-b1a7-4c9d3225a111"
}