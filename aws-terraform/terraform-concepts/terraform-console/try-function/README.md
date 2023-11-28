## Example
```s
variable "context" {
  description = ""
  type        = any
  default = {
    eks_cluster_id  = "my-eks-cluster"
    cluster_version = "1.21"
    vpc_id          = "vpc-12345678"
    private_subnet_ids = [
      "subnet-abcdef01",
      "subnet-ghijklmn",
      "subnet-pqrstuvwxyz"
    ]
    public_subnet_ids = {
      subnet1 = "subnet-pqrstuvwxyz"
      subnet2 = "subnet-12345678"
      subnet3 = "subnet-abcdef01"
    }
    tags = {
      "id"             = "2560"
      "owner"          = "DevOps Easy Learning"
      "teams"          = "DEL"
      "environment"    = "dev"
      "project"        = "del"
      "create_by"      = "Terraform"
      "cloud_provider" = "aws"
    }
  }
}
```

```s
try(var.context.eks_cluster_id, "Not set")
try(var.context.cluster_version, "Not set")
try(var.context.vpc_id, "Not set")

try(var.context.private_subnet_ids, [])
try(var.context.private_subnet_ids[0], "Not set")
try(var.context.private_subnet_ids[1], "Not set")
try(var.context.private_subnet_ids[2], "Not set")

try(var.context.public_subnet_ids, {})
try(values(var.context.public_subnet_ids), [])
try(var.context.public_subnet_ids["subnet1"], "Not set")
try(var.context.public_subnet_ids["subnet2"], "Not set")
try(var.context.public_subnet_ids["subnet3"], "Not set")

try(values(var.context.tags), [])
try(var.context.tags, {})
try(var.context.tags["cloud_provider"], "Not set")
try(var.context.tags["create_by"], "Not set")
try(var.context.tags["environment"], "Not set")
try(var.context.tags["id"], "Not set")
try(var.context.tags["owner"], "Not set")
try(var.context.tags["project"], "Not set")
try(var.context.tags["teams"], "Not set")


# Use the try function to access values within var.context

# 1. Access eks_cluster_id
try(var.context.eks_cluster_id, "Not set")

# 2. Access cluster_version
try(var.context.cluster_version, "Not set")

# 3. Access vpc_id
try(var.context.vpc_id, "Not set")

# 4. Access private_subnet_ids
try(var.context.private_subnet_ids, [])

# 5. Access private_subnet_ids[0]
try(var.context.private_subnet_ids[0], "Not set")

# 6. Access private_subnet_ids[1]
try(var.context.private_subnet_ids[1], "Not set")

# 7. Access private_subnet_ids[2]
try(var.context.private_subnet_ids[2], "Not set")

# 8. Access public_subnet_ids
try(var.context.public_subnet_ids, {})

# 9. Access values of public_subnet_ids
try(values(var.context.public_subnet_ids), [])

# 10. Access public_subnet_ids["subnet1"]
try(var.context.public_subnet_ids["subnet1"], "Not set")

# 11. Access public_subnet_ids["subnet2"]
try(var.context.public_subnet_ids["subnet2"], "Not set")

# 12. Access public_subnet_ids["subnet3"]
try(var.context.public_subnet_ids["subnet3"], "Not set")

# 13. Access values of tags
try(values(var.context.tags), [])

# 14. Access tags
try(var.context.tags, {})

# 15. Access tags["cloud_provider"]
try(var.context.tags["cloud_provider"], "Not set")

# 16. Access tags["create_by"]
try(var.context.tags["create_by"], "Not set")

# 17. Access tags["environment"]
try(var.context.tags["environment"], "Not set")

# 18. Access tags["id"]
try(var.context.tags["id"], "Not set")

# 19. Access tags["owner"]
try(var.context.tags["owner"], "Not set")

# 20. Access tags["project"]
try(var.context.tags["project"], "Not set")

# 21. Access tags["teams"]
try(var.context.tags["teams"], "Not set")

```