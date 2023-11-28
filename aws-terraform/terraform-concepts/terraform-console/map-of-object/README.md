## Example
```s
variable "context" {
  description = "Input configuration for the Node groups"
  type = object({
    eks_cluster_id            = string
    cluster_ca_base64         = string
    cluster_endpoint          = string
    cluster_version           = string
    vpc_id                    = string
    private_subnet_ids        = list(string)
    public_subnet_ids         = map(string)
    worker_security_group_ids = list(string)
    aws_partition_dns_suffix  = string
    aws_partition_id          = string
    iam_role_path             = string
    iam_role_permissions_boundary = string
    tags                      = map(string)
    service_ipv6_cidr         = string
    service_ipv4_cidr         = string
    availability_zones        = map(string)
    security_groups           = map(list(string))
    vpcs                      = map(string)
    ec2_instances             = list(string)
  })
  default = {
    eks_cluster_id            = ""
    cluster_ca_base64         = ""
    cluster_endpoint          = ""
    cluster_version           = ""
    vpc_id                    = ""
    private_subnet_ids        = []
    public_subnet_ids         = {}
    worker_security_group_ids = []
    aws_partition_dns_suffix  = ""
    aws_partition_id          = ""
    iam_role_path             = ""
    iam_role_permissions_boundary = ""
    tags                      = {}
    service_ipv6_cidr         = ""
    service_ipv4_cidr         = ""
    availability_zones        = {}
    security_groups           = {}
    vpcs                      = {}
    ec2_instances             = []
  }
}
```

```s
variable "context" {
  description = "Input configuration for the Node groups"
  type = object({
    eks_cluster_id                = string
    cluster_ca_base64             = string
    cluster_endpoint              = string
    cluster_version               = string
    vpc_id                        = string
    private_subnet_ids            = list(string)
    public_subnet_ids             = map(string)
    worker_security_group_ids     = list(string)
    aws_partition_dns_suffix      = string
    aws_partition_id              = string
    iam_role_path                 = string
    iam_role_permissions_boundary = string
    tags                          = map(string)
    service_ipv6_cidr             = string
    service_ipv4_cidr             = string
    availability_zones            = map(string)
    security_groups               = map(list(string))
    vpcs                          = map(string)
    ec2_instances                 = list(string)
  })
  default = {
    eks_cluster_id    = "my-eks-cluster"
    cluster_ca_base64 = "base64-encoded-ca-data"
    cluster_endpoint  = "https://example-cluster-endpoint.com"
    cluster_version   = "1.21"
    vpc_id            = "vpc-12345678"
    private_subnet_ids = [
      "subnet-abcdef01",
      "subnet-ghijklmn",
      "subnet-pqrstuvwxyz"
    ]
    public_subnet_ids = {
      subnet1 = "subnet-pqrstuvwxyz"
      subnet2 = "subnet-12345678"
      subnet3 = "subnet-abcdef01"
    }
    worker_security_group_ids     = ["sg-abcdef01", "sg-ghijklmn"]
    aws_partition_dns_suffix      = "amazonaws.com"
    aws_partition_id              = "aws"
    iam_role_path                 = "/eks/"
    iam_role_permissions_boundary = "arn:aws:iam::123456789012:policy/MyPermissionsBoundaryPolicy"
    tags = {
      "id"             = "2560"
      "owner"          = "DevOps Easy Learning"
      "teams"          = "DEL"
      "environment"    = "dev"
      "project"        = "del"
      "create_by"      = "Terraform"
      "cloud_provider" = "aws"
    }
    service_ipv6_cidr = "fd00:10:20:30::/64"
    service_ipv4_cidr = "10.20.30.0/24"
    availability_zones = {
      zone1 = "us-east-1a"
      zone2 = "us-east-1b"
      zone3 = "us-east-1c"
    }
    security_groups = {
      sg1 = ["sg-11111111"]
      sg2 = ["sg-22222222"]
      sg3 = ["sg-33333333"]
    }
    vpcs = {
      vpc1 = "vpc-abcdef01"
      vpc2 = "vpc-ghijklmn"
      vpc3 = "vpc-pqrstuvwxyz"
    }
    ec2_instances = ["i-12345678", "i-23456789", "i-34567890"]
  }
}
```

```s
var.context.eks_cluster_id
var.context.cluster_version
var.context.vpc_id

var.context.private_subnet_ids
var.context.private_subnet_ids[0]
var.context.private_subnet_ids[1]
var.context.private_subnet_ids[2]

var.context.public_subnet_ids
values(var.context.public_subnet_ids)
var.context.public_subnet_ids["subnet1"]
var.context.public_subnet_ids["subnet2"]
var.context.public_subnet_ids["subnet3"]

values(var.context.tags)
var.context.tags
var.context.tags["cloud_provider"]
var.context.tags["create_by"]
var.context.tags["environment"]
var.context.tags["id"]
var.context.tags["owner"]
var.context.tags["project"]
var.context.tags["teams"]


# Use direct attribute access to access values within var.context

# 1. Access eks_cluster_id
var.context.eks_cluster_id

# 2. Access cluster_version
var.context.cluster_version

# 3. Access vpc_id
var.context.vpc_id

# 4. Access private_subnet_ids
var.context.private_subnet_ids

# 5. Access private_subnet_ids[0]
var.context.private_subnet_ids[0]

# 6. Access private_subnet_ids[1]
var.context.private_subnet_ids[1]

# 7. Access private_subnet_ids[2]
var.context.private_subnet_ids[2]

# 8. Access public_subnet_ids
var.context.public_subnet_ids

# 9. Access values of public_subnet_ids
values(var.context.public_subnet_ids)

# 10. Access public_subnet_ids["subnet1"]
var.context.public_subnet_ids["subnet1"]

# 11. Access public_subnet_ids["subnet2"]
var.context.public_subnet_ids["subnet2"]

# 12. Access public_subnet_ids["subnet3"]
var.context.public_subnet_ids["subnet3"]

# 13. Access values of tags
values(var.context.tags)

# 14. Access tags
var.context.tags

# 15. Access tags["cloud_provider"]
var.context.tags["cloud_provider"]

# 16. Access tags["create_by"]
var.context.tags["create_by"]

# 17. Access tags["environment"]
var.context.tags["environment"]

# 18. Access tags["id"]
var.context.tags["id"]

# 19. Access tags["owner"]
var.context.tags["owner"]

# 20. Access tags["project"]
var.context.tags["project"]

# 21. Access tags["teams"]
var.context.tags["teams"]

```