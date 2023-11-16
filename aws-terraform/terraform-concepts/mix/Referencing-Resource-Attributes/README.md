## Referencing Cross-Account Resource Attributes
* An outputed attributes can not only be used for the user reference but it can also act as an input to other resources being created via terraform
* Create and EIP and associate it to and EC2 instance using attribute


### Create and EIP and associate it with EC2 instance
```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "myec2" {
   ami = "ami-0947d2ba12ee1ff75"
   instance_type = "t2.micro"
}

resource "aws_eip" "lb" {
  vpc      = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.myec2.id
  allocation_id = aws_eip.lb.id
}
```

### Create an EIP and associate with SG as source
```tf

/*
ingress = Inbound rule : HTTPS  TCP  443  3.94.14.140/32
egress = outbound rule : All traffic  All  All  0.0.0.0/0
*/

provider "aws" {
  region     = "us-east-1"
}

resource "aws_eip" "lb" {
  vpc      = true
}

resource "aws_security_group" "allow_tls" {
  name        = "kplabs-security-group"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.lb.public_ip}/32"]
#   cidr_blocks = [aws_eip.lb.public_ip/32]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

### Create a SG with the default VPC with a region
```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
```

### Allow all port from a SG
```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow alll inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all"
  }
}
```

### Allow port 8080 from SC
```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_security_group" "allow_port_8080" {
  name        = "allow_port_8080"
  description = "Allow allow port 8080 inbound traffic"
   vpc_id      = "vpc-0c5aaf2965a673d06"

  ingress {
    description = "allow port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow port 8080"
  }
}
```

```tf
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
```

### Create a VPC with the SG within the VPC
```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_vpc" "ProdVpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "Production"
  }
}

resource "aws_security_group" "allow_port_8080" {
  name        = "allow_port_8080"
  description = "Allow allow port 8080 inbound traffic"
  vpc_id      = aws_vpc.ProdVpc.id

  ingress {
    description = "allow port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ```

### Allow traffic from the webserver on port 8080 to access the DB on port 3306
```tf
provider "aws" {
  region     = "us-east-1"
}

resource "aws_vpc" "ProdVpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "Production"
  }
}

resource "aws_security_group" "allow_port_8080" {
  name        = "allow_port_8080"
  description = "Allow allow port 8080 inbound traffic"
  vpc_id      = aws_vpc.ProdVpc.id

  ingress {
    description = "allow port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow port 8080"
  }
}

resource "aws_security_group" "allow_port_3306" {
  name        = "allow_port_3306"
  description = "Allow allow port 3306 inbound traffic from web server 8080"
  vpc_id      = aws_vpc.ProdVpc.id

  // allow traffic for TCP 3306
  ingress {
    description = "allow port 3306"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.allow_port_8080.id]
  }

  // outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow port 3306"
  }
}
```