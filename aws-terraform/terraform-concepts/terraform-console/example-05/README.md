## Example



```s
variable "context" {
  description = ""
  type        = any
  default = {
    private_subnet_ids = [
      "subnet-abcdef01",
      "subnet-ghijklmn",
      "subnet-pqrstuvwxyz"
    ]
    public_subnet_ids = [
      "subnet-pqrstuvwxyz",
      "subnet-12345678",
      "subnet-abcdef01"
    ]
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
element(var.context.private_subnet_ids, 0)
element(var.context.private_subnet_ids, 1)
element(var.context.private_subnet_ids, 2)

element(var.context.public_subnet_ids, 0)
element(var.context.public_subnet_ids, 1)
element(var.context.public_subnet_ids, 2)
```

```s
# Use the element function to access list elements and direct attribute access for maps

# 1. Access eks_cluster_id (not present in the variable, so it will return "Not set")
lookup(var.context.eks_cluster_id, "Not set")

# 2. Access cluster_version (not present in the variable, so it will return "Not set")
lookup(var.context.cluster_version, "Not set")

# 3. Access vpc_id (not present in the variable, so it will return "Not set")
lookup(var.context.vpc_id, "Not set")

# 4. Access private_subnet_ids[0]
element(var.context.private_subnet_ids, 0)

# 5. Access private_subnet_ids[1]
element(var.context.private_subnet_ids, 1)

# 6. Access private_subnet_ids[2]
element(var.context.private_subnet_ids, 2)

# 7. Access public_subnet_ids[0]
element(var.context.public_subnet_ids, 0)

# 8. Access public_subnet_ids[1]
element(var.context.public_subnet_ids, 1)

# 9. Access public_subnet_ids[2]
element(var.context.public_subnet_ids, 2)

# 10. Access values of tags
values(var.context.tags)

# 11. Access tags
var.context.tags

# 12. Access tags["cloud_provider"]
var.context.tags["cloud_provider"]

# 13. Access tags["create_by"]
var.context.tags["create_by"]

# 14. Access tags["environment"]
var.context.tags["environment"]

# 15. Access tags["id"]
var.context.tags["id"]

# 16. Access tags["owner"]
var.context.tags["owner"]

# 17. Access tags["project"]
var.context.tags["project"]

# 18. Access tags["teams"]
var.context.tags["teams"]

```