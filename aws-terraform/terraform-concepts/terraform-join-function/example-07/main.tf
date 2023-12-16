variable "year" {
  type    = string
  default = "2023"
}

variable "month" {
  type    = string
  default = "12"
}

variable "day" {
  type    = string
  default = "15"
}

output "formatted_date" {
  value = join("-", [var.year, var.month, var.day])
}
