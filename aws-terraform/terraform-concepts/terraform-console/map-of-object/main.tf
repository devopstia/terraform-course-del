variable "context" {
  description = ""
  type = object({
    eks_cluster_id     = string
    cluster_version    = string
    vpc_id             = string
    private_subnet_ids = list(string)
    public_subnet_ids  = map(string)
    tags               = map(string)
  })
  default = {
    eks_cluster_id  = "my-eks-cluster"
    cluster_version = "1.21"
    vpc_id          = "vpc-12345678"
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
    tags = {
      id             = "2560"
      owner          = "DevOps Easy Learning"
      teams          = "DEL"
      environment    = "dev"
      project        = "del"
      create_by      = "Terraform"
      cloud_provider = "aws"
    }
  }
}



