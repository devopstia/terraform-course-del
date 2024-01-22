variable "command" {
  type    = string
  default = "docker run"
}

variable "args" {
  type    = list(string)
  default = ["-d", "--name=my_container", "my_image"]
}

output "full_command" {
  value = join(" ", concat("tia", var.args))
}