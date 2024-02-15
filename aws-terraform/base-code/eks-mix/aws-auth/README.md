# Manage EKS aws-auth configmap with terraform
https://dev.to/fukubaka0825/manage-eks-aws-auth-configmap-with-terraform-4ndp

```sh
resource "kubernetes_config_map" "aws-auth" {
  data = {
    "mapRoles" = <<EOT
- rolearn: arn:aws:iam::99999999999:role/hoge-role
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
      # Therefore, before you specify rolearn, remove the path. For example, change arn:aws:iam::<123456789012>:role/<team>/<developers>/<eks-admin> to arn:aws:iam::<123456789012>:role/<eks-admin>. FYI:https://docs.aws.amazon.com/eks/latest/userguide/troubleshooting_iam.html#security-iam-troubleshoot-ConfigMap
EOT
  }

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
}
```

## Configmap yaml file
```yaml
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
      rolearn: arn:aws:iam::788210522308:role/eks-node-group-nodes
      username: system:node:{{EC2PrivateDNSName}}
    - groups:
      - system:masters
      rolearn: arn:aws:iam::788210522308:role/EKS-Admin-Role
      username: eks-cluster-admin
    - groups:
      - system:masters
      rolearn: arn:aws:iam::788210522308:role/EKS-Readonly-Role
      username: eks-readonly-group
  mapUsers: |
    - "groups":
      - "system:masters"
      "userarn": "arn:aws:iam::788210522308:user/awsadmin"
      "username": "awsadmin"
    - "groups":
      - "system:masters"
      "userarn": "arn:aws:iam::788210522308:user/awseksadmin"
      "username": "awseksadmin"
    - "groups":
      - "system:masters"
      "userarn": "arn:aws:iam::788210522308:user/awsreadonly"
      "username": "awsreadonly"
```


```
kubectl get cm -n kube-system
kubectl get cm aws-auth -n kube-system -oyaml
kubectl delete cm aws-auth -n kube-system
```