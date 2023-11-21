
resource "aws_subnet" "private-subnet-01" {
  depends_on = [
    aws_vpc.main
  ]
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private-subnets-cdir[0]
  availability_zone = var.aws_availability_zones[0]
  tags = merge(var.common_tags, {
    Name                                        = format("%s-%s-%s-private-01-${var.aws_availability_zones[0]}", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = var.shared
    },
  )
}

resource "aws_subnet" "private-subnet-02" {
  depends_on = [
    aws_vpc.main
  ]
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private-subnets-cdir[1]
  availability_zone = var.aws_availability_zones[1]
  tags = merge(var.common_tags, {
    Name                                        = format("%s-%s-%s-private-02-${var.aws_availability_zones[1]}", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = var.shared
    },
  )
}

resource "aws_subnet" "private-subnet-03" {
  depends_on = [
    aws_vpc.main
  ]
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private-subnets-cdir[2]
  availability_zone = var.aws_availability_zones[2]
  tags = merge(var.common_tags, {
    Name                                        = format("%s-%s-%s-private-03-${var.aws_availability_zones[2]}", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = var.shared
    },
  )
}

resource "aws_subnet" "public-subnet-01" {
  depends_on = [
    aws_vpc.main
  ]
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public-subnet-cidr[0]
  availability_zone       = var.aws_availability_zones[0]
  tags = merge(var.common_tags, {
    Name                                        = format("%s-%s-%s-public-01-${var.aws_availability_zones[0]}", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = var.shared
    },
  )
}

resource "aws_subnet" "public-subnet-02" {
  depends_on = [
    aws_vpc.main
  ]
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public-subnet-cidr[1]
  availability_zone       = var.aws_availability_zones[1]
  tags = merge(var.common_tags, {
    Name                                        = format("%s-%s-%s-public-02-${var.aws_availability_zones[1]}", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = var.shared
    },
  )
}

resource "aws_subnet" "public-subnet-03" {
  depends_on = [
    aws_vpc.main
  ]
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public-subnet-cidr[2]
  availability_zone       = var.aws_availability_zones[2]
  tags = merge(var.common_tags, {
    Name                                        = format("%s-%s-%s-public-03-${var.aws_availability_zones[2]}", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = var.shared
    },
  )
}
