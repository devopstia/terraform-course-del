## Local Reference
```s
module "eks-blue-green-node-group" {
  source                  = "../../modules/eks-blue-green-node-group"
  aws_region                = local.aws_region
  control_plane_name        = local.control_plane_name
  eks_version               = local.eks_version
  private_subnets           = local.private_subnets
  node_min                  = local.node_min
  desired_node              = local.desired_node
  node_max                  = local.node_max
  blue_node_color           = local.blue_node_color
  green_node_color          = local.green_node_color
  blue                      = local.blue
  green                     = local.green
  ec2_ssh_key               = local.ec2_ssh_key
  deployment_nodegroup      = local.deployment_nodegroup
  capacity_type             = local.capacity_type
  ami_type                  = local.ami_type
  instance_types            = local.instance_types
  disk_size                 = local.disk_size
  shared_owned              = local.shared_owned
  enable_cluster_autoscaler = local.enable_cluster_autoscaler
  tags                      = local.tags
}
```

## SSH Local Reference From Github
- You must use ssh key to authentication if it is a private repository
```s
module "eks-blue-green-node-group" {
  source                  = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/eks-blue-green-node-group?ref=main"
  aws_region                = local.aws_region
  control_plane_name        = local.control_plane_name
  eks_version               = local.eks_version
  private_subnets           = local.private_subnets
  node_min                  = local.node_min
  desired_node              = local.desired_node
  node_max                  = local.node_max
  blue_node_color           = local.blue_node_color
  green_node_color          = local.green_node_color
  blue                      = local.blue
  green                     = local.green
  ec2_ssh_key               = local.ec2_ssh_key
  deployment_nodegroup      = local.deployment_nodegroup
  capacity_type             = local.capacity_type
  ami_type                  = local.ami_type
  instance_types            = local.instance_types
  disk_size                 = local.disk_size
  shared_owned              = local.shared_owned
  enable_cluster_autoscaler = local.enable_cluster_autoscaler
  tags                      = local.tags
}
```


## HTTPS Local Reference From Github
- You must use token to authentication if it is a private repository
```s
module "eks-blue-green-node-group" {
  source                  = "git::https://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/eks-blue-green-node-group?ref=main"
  aws_region                = local.aws_region
  control_plane_name        = local.control_plane_name
  eks_version               = local.eks_version
  private_subnets           = local.private_subnets
  node_min                  = local.node_min
  desired_node              = local.desired_node
  node_max                  = local.node_max
  blue_node_color           = local.blue_node_color
  green_node_color          = local.green_node_color
  blue                      = local.blue
  green                     = local.green
  ec2_ssh_key               = local.ec2_ssh_key
  deployment_nodegroup      = local.deployment_nodegroup
  capacity_type             = local.capacity_type
  ami_type                  = local.ami_type
  instance_types            = local.instance_types
  disk_size                 = local.disk_size
  shared_owned              = local.shared_owned
  enable_cluster_autoscaler = local.enable_cluster_autoscaler
  tags                      = local.tags
}
```