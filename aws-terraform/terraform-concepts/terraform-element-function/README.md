## Example
```s
variable "availability_zones" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

element(var.availability_zones, 0)
element(var.availability_zones, 1)
element(var.availability_zones, 2)

## terraform console
element(["us-west-2a", "us-west-2b", "us-west-2c"], 0)
"us-west-2a"
element(["us-west-2a", "us-west-2b", "us-west-2c"], 1)
"us-west-2b"
element(["us-west-2a", "us-west-2b", "us-west-2c"], 1)

"us-west-2c"
```

```s
variable "instance_types" {
  type    = list(string)
  default = ["t2.micro", "t2.small", "t2.medium"]
}

element(var.instance_types, 0)
element(var.instance_types, 1)
element(var.instance_types, 2)

## terraform console
element(["t2.micro", "t2.small", "t2.medium"], 0)
"t2.micro"
element(["t2.micro", "t2.small", "t2.medium"], 1)
"t2.small"
element(["t2.micro", "t2.small", "t2.medium"], 2)
"t2.medium"
```

```s
variable "vm" {
  type = map(list(string))
  default = {
    region                 = "us-east-1"
    availability_zones     = ["us-east-1a", "us-east-1b", "us-east-1c"]
    instance_types         = ["t2.micro", "t2.small", "t2.medium"]
    subnet_id              = ["subnet-096d45c28d9fb4c14", "subnet-05f285a35173783b0", "subnet-0fe3255479ad7c3a4"]
    ami                    = "ami-0fc5d935ebf8bc3bc"
    vpc_security_group_ids = ["sg-0c51540c60857b7ed", "sg-00db218863d2b2a67"]
    key_name               = "jenkins-key"
    volume_size            = "10"
  }
}
element(var.vm["availability_zones"], 0)
element(var.vm["instance_types"], 1)
element(var.vm["subnet_id"], 2)
element(var.vm["vpc_security_group_ids"], 1)
[element(var.vm["availability_zones"], 0), element(var.vm["availability_zones"], 1), 

```


```s
variable "vm" {
  type = map(list(string))
  default = {
    region                 = "us-east-1"
    availability_zones     = ["us-east-1a", "us-east-1b", "us-east-1c"]
    instance_types         = ["t2.micro", "t2.small", "t2.medium"]
    subnet_id              = ["subnet-096d45c28d9fb4c14", "subnet-05f285a35173783b0", "subnet-0fe3255479ad7c3a4"]
    ami                    = "ami-0fc5d935ebf8bc3bc"
    vpc_security_group_ids = ["sg-0c51540c60857b7ed", "sg-00db218863d2b2a67"]
    key_name               = "jenkins-key"
    volume_size            = "10"
  }
}
element(var.vm["availability_zones"], 2)]
[element(var.vm["instance_types"], 0), element(var.vm["instance_types"], 1), element(var.vm["instance_types"], 2)]
[element(var.vm["subnet_id"], 0), element(var.vm["subnet_id"], 1), element(var.vm["subnet_id"], 2)]
element([var.vm["ami"]], 0)
```