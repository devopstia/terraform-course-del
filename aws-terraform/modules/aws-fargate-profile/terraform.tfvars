aws_region   = "us-east-1"
cluster_name = "2560-dev-del"
private_subnets = {
  us-east-1a = "subnet-096d45c28d9fb4c14"
  us-east-1b = "subnet-05f285a35173783b0"
  us-east-1c = "subnet-0fe3255479ad7c3a4"
}

fargate-profiles = [
  "external-dns",
  "app",
]
