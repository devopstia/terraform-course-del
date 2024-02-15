## Using an IAM role in the AWS CLI
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html

```sh
aws eks update-kubeconfig --name eks --region us-east-1 --profile default
k get sc

aws eks update-kubeconfig --name eks --region us-east-1 --profile ADFS-AWS-ReadOnly
k get sc

aws eks update-kubeconfig --name eks --region us-east-1 --profile ADFS-AWS-Admins
k get sc

aws eks update-kubeconfig --name eks --region us-east-1 --profile ADFS-EKS-Admins
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
aws eks update-kubeconfig --name eks --region us-east-1 --profile awsadmin
k get sc

aws eks update-kubeconfig --name eks --region us-east-1 --profile awseksadmin
k get sc

aws eks update-kubeconfig --name eks --region us-east-1 --profile awsreadonly
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


## Drain and taint a node
```sh
kubectl drain ip-10-0-2-130.ec2.internal --ignore-daemonsets=false --force  --delete-local-data
kubectl taint nodes ip-10-0-1-210.ec2.internal gpu=true:NoSchedule
kubectl taint nodes ip-10-0-2-130.ec2.internal gpu=true:NoSchedule
```

## Where can I get a list of Kubernetes API resources and subresources?
- [Here](https://stackoverflow.com/questions/49396607/where-can-i-get-a-list-of-kubernetes-api-resources-and-subresources#:~:text=Using%20kubectl%20api%2Dresources%20%2Do,verbs%20and%20associated%20API%2Dgroup.)
```
kubectl api-resources -o wide
```

## AWS IRSA 
- it use by EKS pods to access other AWS services

When Kubernetes comes to public cloud AWS, there is a issue that each K8S Pod needs specific permission to access AWS cloud resource, but AWS only can grant the permission under EC2 instance level, instead of K8S Pod level, hence, there are two workaround methods emerging in the community:

1. Grant the permission that all of K8S Pods are required in the EC2 IAM Role Profile ← This is a bad idea, it broken the Principle of Least Privilege

2. Use the third-party solution like kube2iam, kiam and Zalando’s IAM controller ← Intercepting the requests to the EC2 metadata API to perform a call to the STS API to retrieve temporary credentials

Finally, AWS made changes in the AWS identity APIs to recognize Kubernetes pods, so each K8S Pod can have specific IAM Role to acquire proper permission to access AWS cloud resource (This feature called `IRSA`). 


**Keys items for IRSA implimentation:**
- AWS IAM identity provider
- EKS openID connect provider
- AWS STS assume role with with web identity API
- AWS IAM temperary creadential
- IRSA IAM for service account


**This is the cluster root certificate that is not going to change till `2037`** and it can be hardcoded instead of writing another terraform block of code to get it. This provide by AWS
```t
variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}
```

```t
variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}


resource "aws_iam_openid_connect_provider" "example" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [var.eks_oidc_root_ca_thumbprint]
  url             = aws_eks_cluster.eks.identity.0.oidc.0.issuer

  tags = {
    "key" = "EKS iam openid connect provider"
  }
}
```

**Remove https on OpenID Connect provider URL**
```t
https://oidc.eks.us-east-1.amazonaws.com/id/23380E051E31F6AFBF534E53CB8314DF

output "identity-oidc-url" {
  value = split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1]
}

# output
oidc.eks.us-east-1.amazonaws.com/id/23380E051E31F6AFBF534E53CB8314DF

# Federated
output "aws_iam_openid_connect_provider_url" {
  value = join("/", ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider", split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1]])
}

# output
arn:aws:iam::788210522308:oidc-provideroidc.eks.us-east-1.amazonaws.com/id/23380E051E31F6AFBF534E53CB8314DF

# StringEquals
 join(":", [split("https://", data.aws_eks_cluster.example.identity.0.oidc.0.issuer)[1], "sub"]) : "system:serviceaccount:${var.namespace}:${var.service_account_name}"

# output
"oidc.eks.us-east-1.amazonaws.com/id/23380E051E31F6AFBF534E53CB8314DF:sub": "system:serviceaccount:kube-system:irsa-sevice-account"
```


## Create AWS EKS Fargate Using Terraform (EFS, HPA, Ingress, ALB, IRSA, Kubernetes, Helm, Tutorial)
https://antonputra.com/amazon/create-aws-eks-fargate-using-terraform/






























## How to export the cluster .kube/config file?
1- Login in AWS using the CLI first with your secret and access key

2- Run the below command to export the .kube/config file in your home directory
```
aws eks update-kubeconfig --name [cluster_name] --region [region]
aws eks update-kubeconfig --name eks --region us-east-1 
```
Example: 
```
aws eks update-kubeconfig --name 2560-adl-dev --region us-east-1
aws eks update-kubeconfig --name 2560-adl-dev --region us-east-1 --alias=alpha-nonprod
aws eks update-kubeconfig --name 2560-adl-dev --region us-east-1 --alias=alpha-nonprod --profile=readonly
aws eks update-kubeconfig --name 2560-adl-dev --region us-east-1 --profile=readonly
```

## Check node with labels
- https://www.devopsschool.com/blog/deep-dive-into-kubernetes-taint-with-node/
```
kubectl get no -l deployment.nodegroup=blue
kubectl get no -l deployment.nodegroup=green

kubectl get no -l deployment.nodegroup=blue |awk -F" " '{print$1}'
kubectl get no -l deployment.nodegroup=green |awk -F" " '{print$1}'

NODE=`kubectl get no -l deployment.nodegroup=blue |awk -F" " '{print$1}'`
for i in $NODE
do 
  kubectl taint $i $i=DoNotSchedulePods:NoExecute
  kubectl drain $i
done


kubectl taint nodes node2 node2=DoNotSchedulePods:NoExecute
```


## Check you current context 
```
kubectl config get-contexts
```

## Login with assume role readonly
https://aws.amazon.com/premiumsupport/knowledge-center/amazon-eks-cluster-access/
https://aws.amazon.com/premiumsupport/knowledge-center/eks-iam-permissions-namespaces/
```sh
# Export AWS Account ID
ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
echo $ACCOUNT_ID

# Assume IAM Role
aws sts assume-role --role-arn "arn:aws:iam::<REPLACE-YOUR-ACCOUNT-ID>:role/eks-admin-role" --role-session-name eksadminsession

aws sts assume-role --role-arn "arn:aws:iam::$ACCOUNT_ID:role/EKS-Readonly-Role" --role-session-name eksadminsession

# GET Values and replace here
export AWS_ACCESS_KEY_ID=RoleAccessKeyID
export AWS_SECRET_ACCESS_KEY=RoleSecretAccessKey
export AWS_SESSION_TOKEN=RoleSessionToken

export AWS_ACCESS_KEY_ID=ASIA3PBICDDCDOV5SVGH
export AWS_SECRET_ACCESS_KEY=E8IwuhU9gdybX+gxA+kMaxp7s+SyyX/aOgBgLktp
export AWS_SESSION_TOKEN=IQoJb3JpZ2luX2VjEIzxesgrawtgaywhsesahahhawrz=

## Sample Output
aws sts get-caller-identity
{
    "UserId": "AROASUF7HC7SRFLFPNG7F:eksadminsession",
    "Account": "180789647333",
    "Arn": "arn:aws:sts::180789647333:assumed-role/hr-dev-eks-readonly-role/eksadminsession"
}

# Configure kubeconfig for kubectl
aws eks --region <region-code> update-kubeconfig --name <cluster_name>
aws eks --region us-east-1 update-kubeconfig --name 2560-adl-dev 


unset AWS_ACCESS_KEY_ID
unset AWS_SESSION_TOKEN
unset AWS_SECRET_ACCESS_KEY
```




## Cluster public end point or API server end point
- This is the end point that we use to access EKS API through  `kubectl` CLI. It should in the public subnet so that the end users can access it. 
- nslookup will display the public IP that end point is using
- "https://66F9A55FD4E767E8D30374F8E2089C06.gr7.us-east-1.eks.amazonaws.com"
```
nslookup 66F9A55FD4E767E8D30374F8E2089C06.gr7.us-east-1.eks.amazonaws.com
Server:         127.0.0.53
Address:        127.0.0.53#53

Non-authoritative answer:
Name:   66F9A55FD4E767E8D30374F8E2089C06.gr7.us-east-1.eks.amazonaws.com
Address: 3.228.196.13
Name:   66F9A55FD4E767E8D30374F8E2089C06.gr7.us-east-1.eks.amazonaws.com
Address: 35.171.69.38
```

## Connect to ubuntu instance in the private subnet
```
cd /temp
ssh -i "jenkins-key.pem" ubuntu@10.0.18.195
```

## Connect to EKS node from the bastion host
```
cd /temp
ssh -i "jenkins-key.pem" ec2-user@10.0.18.195
```

## kubelet information
```
systemctl status kubelet
ps -aux |grep kubelet
```
- it has the control plane API end point to communicate with the API server
- it has the control plane API server information
- It is using the public IP to connect to the control plan
```
cat /var/lib/kubelet/kubeconfig
apiVersion: v1
kind: Config
clusters:
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://66F9A55FD4E767E8D30374F8E2089C06.gr7.us-east-1.eks.amazonaws.com
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubelet
  name: kubelet
current-context: kubelet
users:
- name: kubelet
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: /usr/bin/aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "2560-adl-dev"
        - --region
```

## kube-proxy information
It does not have a daemon
```
ps -aux |grep kube-proxy
```

## Docker information
```
ps -aux |grep docker
systemctl status docker
docker --version
```

## Verify Pod Infra Container for Kubelete
Example: --pod-infra-container-image=602401143452.dkr.ecr.us-east-1.amazonaws.com/eks/pause:3.1-eksbuild.1
Observation:
1. This Pod Infra container will be downloaded from AWS Elastic Container Registry ECR
2. All the EKS related system pods also will be downloaded from AWS ECR only


## Terraform EKS Nodegroups with custom Launch Templates
https://wangpp.medium.com/terraform-eks-nodegroups-with-custom-launch-templates-5b6a199947f


## AWS EKS AMI type
https://docs.aws.amazon.com/eks/latest/APIReference/API_Nodegroup.html





## EKS OpenID Connect Well Known Configuration URL
- We can also call it as `OpenID Connect Discovery URL`
- **Discovery:** Defines how Clients dynamically discover information about OpenID Providers
```t
# Get OpenID Connect provider URL for EKS Cluster
Go to Services -> EKS -> hr-dev-eksdemo1 -> Configuration -> Details -> OpenID Connect provider URL

# EKS OpenID Connect Well Known Configuration URL
<EKS OpenID Connect provider URL>/.well-known/openid-configuration

# Sample
https://oidc.eks.us-east-1.amazonaws.com/id/EC973221A6C1BC248C79CFD5455EEECC/.well-known/openid-configuration
```
- **Sample Output from EKS OpenID Connect Well Known Configuration URL**
```json
// 20220106104407
// https://oidc.eks.us-east-1.amazonaws.com/id/EC973221A6C1BC248C79CFD5455EEECC/.well-known/openid-configuration

{
  "issuer": "https://oidc.eks.us-east-1.amazonaws.com/id/EC973221A6C1BC248C79CFD5455EEECC",
  "jwks_uri": "https://oidc.eks.us-east-1.amazonaws.com/id/EC973221A6C1BC248C79CFD5455EEECC/keys",
  "authorization_endpoint": "urn:kubernetes:programmatic_authorization",
  "response_types_supported": [
    "id_token"
  ],
  "subject_types_supported": [
    "public"
  ],
  "claims_supported": [
    "sub",
    "iss"
  ],
  "id_token_signing_alg_values_supported": [
    "RS256"
  ]
}
```