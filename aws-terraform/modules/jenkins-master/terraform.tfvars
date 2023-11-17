aws_region       = "us-east-1"
enable_user_data = false
use_custom_ami   = true

private_subnets = {
  us-east-1a = "subnet-096d45c28d9fb4c14"
  us-east-1b = "subnet-05f285a35173783b0"
  us-east-1c = "subnet-0fe3255479ad7c3a4"
}

public_subnets = {
  us-east-1a = "subnet-096d45c28d9fb4c14"
  us-east-1b = "subnet-05f285a35173783b0"
  us-east-1c = "subnet-0fe3255479ad7c3a4"
}

vpc_id             = "vpc-068852590ea4b093b"
image_id           = "ami-053b0d53c279acc90"
key_name           = "jenkins-key"
min_size           = 1
max_size           = 1
instance_type      = "t2.medium"
volume_size        = "50"
load_balancer_type = "application"
internal-elb       = false
domain             = "devopseasylearning.net"
subdomain_name     = "del-dev-jenkins"
jenkins-role-name  = "jenkins-master-role"

common_tags = {
  "Teams"         = "DEL"
  "environment"   = "dev"
  "project"       = "del"
  "createBy"      = "Terraform"
  "cloudProvider" = "aws"
}
