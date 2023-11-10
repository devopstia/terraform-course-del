
## Example
```s
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Change to the desired AMI ID
  instance_type = "t2.micro"             # Change to the desired instance type
  key_name      = "your-key-pair-name"   # Change to your SSH key pair name
  vpc_security_group_ids = ["add_securiy_group_here"] # Associate the security group
  subnet_id = "add_subnet_here" # Associate with a subnet in the specified VPC

  # Define the root EBS volume with the specified size
  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name = "vm"
    Create_By = "Terraform"
  }
}
```