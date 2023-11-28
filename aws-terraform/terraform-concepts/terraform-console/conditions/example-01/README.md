## Example
```s
var.green_node_color == "green" && var.green ? var.desired_node : 0
var.green_node_color == "green" && var.green ? var.node_min : 0
var.green_node_color == "green" && var.green ? var.node_max : var.node_max

var.blue_node_color == "blue" && var.blue ? var.desired_node : 0
var.blue_node_color == "blue" && var.blue ? var.node_min : 0
var.blue_node_color == "blue" && var.blue ? var.node_max : var.node_max

```