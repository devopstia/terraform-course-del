variable "base_url" {
  type    = string
  default = "https://api.example.com"
}

variable "api_path" {
  type    = string
  default = "v1/resource"
}

output "api_url" {
  value = join("/", [var.base_url, var.api_path])
}
