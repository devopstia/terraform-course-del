## Example

```s
lookup(var.context, "eks_cluster_id", "Not set")
lookup(var.context, "cluster_version", "Not set")
lookup(var.context, "vpc_id", "Not set")


# The lookup function is primarily used for working with maps and not for directly accessing elements from a list by index
lookup(var.context, "private_subnet_ids", [])
lookup(var.context.private_subnet_ids, 0, "Not set")
lookup(var.context.private_subnet_ids, 1, "Not set")
lookup(var.context.private_subnet_ids, 2, "Not set")

element(var.context.private_subnet_ids, 0)
element(var.context.private_subnet_ids, 1)
element(var.context.private_subnet_ids, 2)

var.context.private_subnet_ids[0]
var.context.private_subnet_ids[1]
var.context.private_subnet_ids[2]


lookup(var.context, "public_subnet_ids", {})
values(var.context.public_subnet_ids)
lookup(var.context.public_subnet_ids, "subnet1", "Not set")
lookup(var.context.public_subnet_ids, "subnet2", "Not set")
lookup(var.context.public_subnet_ids, "subnet3", "Not set")


lookup(var.context.tags, "*", [])
lookup(var.context, "tags", {})
lookup(var.context.tags, "cloud_provider", "Not set")
lookup(var.context.tags, "create_by", "Not set")
lookup(var.context.tags, "environment", "Not set")
lookup(var.context.tags, "id", "Not set")
lookup(var.context.tags, "owner", "Not set")
lookup(var.context.tags, "project", "Not set")
lookup(var.context.tags, "teams", "Not set")
```