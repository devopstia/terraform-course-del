## Where can I get a list of Kubernetes API resources and subresources?
- [Here](https://stackoverflow.com/questions/49396607/where-can-i-get-a-list-of-kubernetes-api-resources-and-subresources#:~:text=Using%20kubectl%20api%2Dresources%20%2Do,verbs%20and%20associated%20API%2Dgroup.)
```
kubectl api-resources -o wide
```
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: eksreadonly-clusterrole
rules:
- apiGroups:
  - ""
  resources:
  - nodes
  - namespaces
  - pods
  - events
  - services
  - configmaps
  - serviceaccounts
  - persistentvolumeclaim
  - persistentvolumes
  - secrets
  verbs:
  - get
  - list
- apiGroups:
  - apps
  resources:
  - deployments
  - daemonsets
  - statefulsets
  - replicasets
  verbs:
  - get
  - list
- apiGroups:
  - batch
  resources:
  - jobs
  verbs:
  - get
  - list
```
OR

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: eksreadonly-clusterrole
rules:
  - apiGroups: [""]
    resources: ["nodes", "namespaces", "pods", "events", "services", "configmaps", "serviceaccounts", "persistentvolumeclaim", "persistentvolumes", "secrets"]
    verbs: ["get", "list"]
  - apiGroups: ["apps"]
    resources: ["deployments" ,"daemonsets" ,"statefulsets" ,"replicasets"]
    verbs: ["get", "list"]
  - apiGroups: ["batch"]
    resources: ["jobs"]
    verbs: ["get", "list"]
```


## Allow readonly for all kubernetes resources
```s
resource "kubernetes_cluster_role_v1" "eksreadonly_clusterrole" {
  metadata {
    name = "eksreadonly-clusterrole"
  }
  rule {
    api_groups = [""] # These come under core APIs
    resources  = ["*"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["*"]
    verbs      = ["get", "list"]
  }
  rule {
    api_groups = ["batch"]
    resources  = ["*"]
    verbs      = ["get", "list"]
  }
}
```

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: eksreadonly-clusterrole
rules:
  - apiGroups: [""]
    resources: ["*"]
    verbs: ["get", "list"]
  - apiGroups: ["apps"]
    resources: ["*"]
    verbs: ["get", "list"]
  - apiGroups: ["batch"]
    resources: ["*"]
    verbs: ["get", "list"]
```

## Check aws-auth default file
kubectl edit cm aws-auth -n kube-system -oyaml 

```yaml
apiVersion: v1
data:
  mapRoles: |
    - groups:
      - system:bootstrappers
      - system:nodes
      rolearn: arn:aws:iam::788210522308:role/2560-dev-alpha-blue-green-node-group-role
      username: system:node:{{EC2PrivateDNSName}}
kind: ConfigMap
metadata:
  creationTimestamp: "2023-05-15T12:23:18Z"
  name: aws-auth
  namespace: kube-system
  resourceVersion: "3226"
  uid: a8529fb3-8606-4b72-b348-3c45d98258d7
```

## Using AWS console with role
When we are using roles, we must assume the role when we access AWS to have the proper permission. We will used the follwing role name:
- ADFS-AWS-ReadOnly
- ADFS-AWS-Admins
- ADFS-EKS-Admins

## Using an IAM role in the AWS CLI
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html

```sh
aws eks update-kubeconfig --name 2560-dev-alpha --region us-east-1 --profile default
k get sc

aws eks update-kubeconfig --name 2560-dev-alpha --region us-east-1 --profile ADFS-AWS-ReadOnly
k get sc

aws eks update-kubeconfig --name 2560-dev-alpha --region us-east-1 --profile ADFS-AWS-Admins
k get sc

aws eks update-kubeconfig --name 2560-dev-alpha --region us-east-1 --profile ADFS-EKS-Admins
k get sc
```

```sh
[default]
aws_access_key_id = AKIA3PBICDDCHAPBJ7DZ
aws_secret_access_key = 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


[ADFS-AWS-ReadOnly]
region = us-east-1
source_profile = default
role_arn = arn:aws:iam::788210522308:role/AWS-ReadOnly-Role

[ADFS-AWS-Admins]
region = us-east-1
source_profile = default
role_arn = arn:aws:iam::788210522308:role/AWS-Admin-Role

[ADFS-EKS-Admins]
region = us-east-1
source_profile = default
role_arn = arn:aws:iam::788210522308:role/AWS-EKS-Admin-Role
```

```
aws eks update-kubeconfig --name 2560-dev-alpha --region us-east-1 --profile awsadmin
k get sc

aws eks update-kubeconfig --name 2560-dev-alpha --region us-east-1 --profile awseksadmin
k get sc

aws eks update-kubeconfig --name 2560-dev-alpha --region us-east-1 --profile awsreadonly
k get sc
```

```sh
[awsadmin]
region = us-east-1
aws_access_key_id = AKIA3PBICDDCJ5L5FYUY
aws_secret_access_key = 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

[awseksadmin]
region = us-east-1
aws_access_key_id = AKIA3PBICDDCKJEV7CGL
aws_secret_access_key = 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

[awsreadonly]
region = us-east-1
aws_access_key_id = AKIA3PBICDDCOH6NL5OQ
aws_secret_access_key = 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
```
