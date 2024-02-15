
# Get your account number
data "aws_caller_identity" "current" {
}

locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - groups:
      - system:bootstrappers
      - system:nodes
      rolearn: arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/demo-cluster-eks-node-group
      username: system:node:{{EC2PrivateDNSName}}
    - groups:
      - system:masters
      rolearn: arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/EKS-Admin-Role
      username: eks-cluster-admin
    - groups:
      - system:masters
      rolearn: arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/EKS-Readonly-Role
      username: eks-readonly-group
  mapUsers: |
    - "groups":
      - "system:masters"
      "userarn": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/awsadmin"
      "username": "awsadmin"
    - "groups":
      - "system:masters"
      "userarn": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/awseksadmin"
      "username": "awseksadmin"
    - "groups":
      - "system:masters"
      "userarn": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/awsreadonly"
      "username": "awsreadonly"
CONFIGMAPAWSAUTH
}

# Generate Node Auth File
resource "local_file" "cluster-auth" {
  content  = local.config_map_aws_auth
  filename = "aws-auth.yaml"
}

resource "null_resource" "cluster-auth-apply" {
  depends_on = [local_file.cluster-auth]
  provisioner "local-exec" {
    command = "kubectl apply -f aws-auth.yaml"
  }
}

