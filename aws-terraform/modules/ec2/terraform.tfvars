aws_region                    = "us-east-1"
distribution                  = "ubuntu"
ec2_instance_type             = "t2.micro"
sg_name                       = "test"
instance_name                 = "test"
vpc_id                        = "vpc-068852590ea4b093b"
subnet_id                     = "subnet-096d45c28d9fb4c14"
root_volume_size              = 10
instance_count                = 1
enable_termination_protection = false
ec2_instance_key_name         = "terraform-aws"
allowed_ports = [
  22,
  80,
  8080
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
