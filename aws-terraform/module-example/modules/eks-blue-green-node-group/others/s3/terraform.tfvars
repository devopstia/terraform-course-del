aws_region = "us-east-1"

common_tags = {
  "AssetID"       = "2560"
  "Environment"   = "dev"
  "Project"       = "alpha"
  "CreateBy"      = "Terraform"
  "cloudProvider" = "aws"
}

eks_version  = "1.23"
node_min     = "4"
desired_node = "4"
node_max     = "6"

blue_node_color  = "blue"
green_node_color = "green"

blue  = false
green = true

ec2_ssh_key               = "terraform"
deployment_nodegroup      = "blue_green"
capacity_type             = "ON_DEMAND"
ami_type                  = "AL2_x86_64"
instance_types            = "t2.micro"
disk_size                 = "10"
shared_owned              = "shared"
enable_cluster_autoscaler = "true"
