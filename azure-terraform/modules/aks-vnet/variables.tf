
variable "location" {
  type    = string
  default = "Central US"
}

variable "tags" {
  type = map(any)
}

variable "subscription_id" {
  type = string
}
