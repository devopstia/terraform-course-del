data "aws_ami" "rhel" {
  most_recent = true

  filter {
    name   = "name"
    values = ["*Red Hat*", "*RHEL*"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  owners = ["309956199498"]
}
