## Example
```s
format("%s-%s-%s-private-01", var.tags["id"], var.tags["environment"], var.tags["project"])
format("%s-%s-%s-private-02", var.tags["id"], var.tags["environment"], var.tags["project"])
format("%s-%s-%s-private-03", var.tags["id"], var.tags["environment"], var.tags["project"])

format("%s-%s-%s-public-01", var.tags["id"], var.tags["environment"], var.tags["project"])
format("%s-%s-%s-public-02", var.tags["id"], var.tags["environment"], var.tags["project"])
format("%s-%s-%s-public-03", var.tags["id"], var.tags["environment"], var.tags["project"])


format("%s-%s-%s-%s-private-01", var.tags["id"], var.tags["environment"], var.tags["project"], var.tags["cloud_provider"])
format("%s-%s-%s-%s-private-02", var.tags["id"], var.tags["environment"], var.tags["project"], var.tags["cloud_provider"])
format("%s-%s-%s-%s-private-03", var.tags["id"], var.tags["environment"], var.tags["project"], var.tags["cloud_provider"])

format("%s-%s-%s-%s-public-01", var.tags["id"], var.tags["environment"], var.tags["project"], var.tags["cloud_provider"])
format("%s-%s-%s-%s-public-02", var.tags["id"], var.tags["environment"], var.tags["project"], var.tags["cloud_provider"])
format("%s-%s-%s-%s-public-03", var.tags["id"], var.tags["environment"], var.tags["project"], var.tags["cloud_provider"])


format("%s-%s-%s-private-01", var.context.tags["id"],var.context.tags["environment"], var.context.tags["project"])
format("%s-%s-%s-private-02", var.context.tags["id"], var.context.tags["environment"], var.context.tags["project"])
format("%s-%s-%s-private-03", var.context.tags["id"], var.context.tags["environment"], var.context.tags["project"])

format("%s-%s-%s-public-01", var.context.tags["id"],var.context.tags["environment"], var.context.tags["project"])
format("%s-%s-%s-public-01", var.context.tags["id"], var.context.tags["environment"], var.context.tags["project"])
format("%s-%s-%s-public-01", var.context.tags["id"], var.context.tags["environment"], var.context.tags["project"])

format("%s-%s-%s-%s-private-01", var.context.tags["id"],var.context.tags["environment"], var.context.tags["project"], var.context.tags["cloud_provider"])
format("%s-%s-%s-%s-private-02", var.context.tags["id"], var.context.tags["environment"], var.context.tags["project"], var.context.tags["cloud_provider"])
format("%s-%s-%s-%s-private-03", var.context.tags["id"], var.context.tags["environment"], var.context.tags["project"], var.context.tags["cloud_provider"])

format("%s-%s-%s-%s-public-01", var.context.tags["id"],var.context.tags["environment"], var.context.tags["project"], var.context.tags["cloud_provider"])
format("%s-%s-%s-%s-public-02", var.context.tags["id"], var.context.tags["environment"], var.context.tags["project"], var.context.tags["cloud_provider"])
format("%s-%s-%s-%s-public-03", var.context.tags["id"], var.context.tags["environment"], var.context.tags["project"], var.context.tags["cloud_provider"])
```