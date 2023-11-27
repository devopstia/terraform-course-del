```s
# Define a variable with nested maps
variable "instance_types" {
  type = map(object({
    ami_id      = string
    cpu_cores   = number
    memory_gb   = number
  }))
  default = {
    "t2.micro" = {
      ami_id    = "ami-12345678"
      cpu_cores = 1
      memory_gb = 1
    }
    "t2.small" = {
      ami_id    = "ami-98765432"
      cpu_cores = 1
      memory_gb = 2
    }
  }
}
```
