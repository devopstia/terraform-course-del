ami_name           = "jenkins-node"
instance_type      = "t2.micro"
region             = "us-east-1"
source_ami         = "ami-06aa3f7caf3a30282" #Canonical, Ubuntu, 20.04 LTS
vpc_id             = "vpc-068852590ea4b093b"
subnet_id          = "subnet-096d45c28d9fb4c14"
security_group_ids = "sg-0c51540c60857b7ed"
ssh_username       = "ubuntu"
volume_size        = 20

tags = {
  "Name"           = "ubuntu-ami"
  "id"             = "2560"
  "owner"          = "DevOps Easy Learning"
  "teams"          = "DEL"
  "environment"    = "dev"
  "project"        = "del"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
}