## Set up IAM permissions and deploy ExternalDNS
https://aws.amazon.com/premiumsupport/knowledge-center/eks-set-up-externaldns/

## Amazon container image registries
https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html
```
AWS Region	Registry
sa-east-1	    602401143452.dkr.ecr.sa-east-1.amazonaws.com
us-east-1	    602401143452.dkr.ecr.us-east-1.amazonaws.com
us-east-2	    602401143452.dkr.ecr.us-east-2.amazonaws.com
us-gov-east-1	151742754352.dkr.ecr.us-gov-east-1.amazonaws.com
us-gov-west-1	013241004608.dkr.ecr.us-gov-west-1.amazonaws.com
us-west-1	    602401143452.dkr.ecr.us-west-1.amazonaws.com
us-west-2	    602401143452.dkr.ecr.us-west-2.amazonaws.com
```

## argo-cd
- ArgoCD need at least t2.medium node
- PS: the namespace and the release name must be argo-cd
```sh
## install with default values
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
kubectl create namespace argo-cd
helm upgrade argo-cd --install argo/argo-cd -n argo-cd --set server.service.type=LoadBalancer --set fullnameOverride=argocd
kubectl get po -n argo-cd
kubectl get svc -n argo-cd

## Install will value files
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm fetch argo/argo-cd --untar

kubectl create ns argo-cd
helm upgrade argo-cd --install ../charts/argo-cd --values argo-cd.yaml --namespace argo-cd
kubectl get po -n argo-cd
kubectl get svc -n argo-cd

## Get admin credentials
default username = admin
kubectl -n argo-cd get secret
kubectl -n argo-cd edit secret argocd-initial-admin-secret -oyaml
argocd-initial-admin-secret
echo "VkdvaTJzWThjZTA5bjVuYw==" | base64 -d

kubectl -n argo-cd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

## uninstall 
helm uninstall argo-cd -n argo-cd
kubectl delete crd applications.argoproj.io
```


## cluster-autoscaler
```
kubectl create ns cluster-autoscaler
helm upgrade cluster-autoscaler --install ../charts/cluster-autoscaler --values cluster-autoscaler.yaml --namespace cluster-autoscaler
```

## aws-load-balancer-controller
```
helm upgrade aws-load-balancer-controller --install ../charts/aws-load-balancer-controller --values aws-load-balancer-controller.yaml --namespace kube-system
```

## aws-ebs-csi-driver
```
kubectl create ns aws-ebs-csi-driver
helm upgrade aws-ebs-csi-driver --install ../charts/aws-ebs-csi-driver --values aws-ebs-csi-driver.yaml --namespace aws-ebs-csi-driver

helm uninstall aws-ebs-csi-driver  -n  aws-ebs-csi-driver
```

## external-dns
```
kubectl create ns external-dns
helm upgrade external-dns --install ../charts/external-dns --values external-dns.yaml --namespace external-dns
```

## metrics-server
```
helm upgrade metrics-server --install ../charts/metrics-server --values metrics-server.yaml --namespace kube-system

helm uninstall metrics-server 
```

## ns aws-efs-csi-driver
```
kubectl create ns aws-efs-csi-driver
helm upgrade aws-efs-csi-driver --install ../charts/aws-efs-csi-driver --values aws-efs-csi-driver.yaml --namespace aws-efs-csi-driver
```

## covid19
```
kubectl create ns covid19
helm upgrade covid19 --install ../charts/applications --values covid19.yaml --namespace covid19

kubectl label namespace covid19 istio-injection=enabled
```

## articles
```
kubectl create ns articles
helm upgrade articles --install ../charts/applications --values articles.yaml --namespace articles

kubectl label namespace articles istio-injection=enabled
```

## kube2iam
```
kubectl create ns kube2iam
helm upgrade kube2iam --install ../charts/kube2iam --values kube2iam.yaml --namespace kube2iam
```

## datadog 
```yaml
# Get metrics from Kubernetes service in real-time
# In your Helm values.yaml, add the following:

datadog:
  # (...)
  kubeStateMetricsCore:
    enabled: true
```

```
kubectl create ns datadog
helm upgrade datadog --install ../charts/datadog --values datadog.yaml --namespace datadog
kubectl get po -n datadog
helm uninstall datadog --namespace datadog
``` 

## vertical-pod-autoscaler
- This chart has a dependency
- It depends on `metrics-server` chart
https://github.com/cowboysysop/charts/tree/master/charts/vertical-pod-autoscaler

```
helm repo add cowboysysop https://cowboysysop.github.io/charts/
helm fetch <repo-name>/<chart-name> --untar
helm fetch cowboysysop/vertical-pod-autoscaler --untar
```
```
kubectl create ns vertical-pod-autoscaler
helm upgrade vertical-pod-autoscaler --install ../charts/vertical-pod-autoscaler --values vertical-pod-autoscaler.yaml --namespace kube-system
```

## goldilocks
- https://github.com/FairwindsOps/charts/blob/master/stable/goldilocks/README.md

```
helm repo add fairwinds-stable https://charts.fairwinds.com/stable
helm install goldilocks fairwinds-stable/goldilocks --namespace goldilocks

helm fetch <repo-name>/<chart-name> --untar
helm fetch fairwinds-stable/goldilocks --untar
```

```
kubectl create ns goldilocks
helm upgrade goldilocks --install ../charts/goldilocks --values goldilocks.yaml --namespace goldilocks
```

```sh
# You need to label the namespaces
kubectl label ns dev goldilocks.fairwinds.com/enabled=true
kubectl label ns kube-system goldilocks.fairwinds.com/enabled=true
kubectl label ns vertical-pod-autoscaler goldilocks.fairwinds.com/enabled=true
kubectl label ns metrics-server goldilocks.fairwinds.com/enabled=true
```

## SonarQube
https://docs.sonarsource.com/sonarqube/9.9/setup-and-upgrade/deploy-on-kubernetes/deploy-sonarqube-on-kubernetes/

helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube
helm repo update
kubectl create namespace sonarqube
helm upgrade --install -n sonarqube sonarqube sonarqube/sonarqube 
helm upgrade --install -n sonarqube sonarqube sonarqube/sonarqube --values sonarqube.yaml

kubectl get po -n sonarqube
kubectl get svc -n sonarqube

helm uninstall sonarqube -n sonarqube




### How to export the cluster .kube/config file?
1- Login in AWS using the CLI first with your secret and access key
2- Run the below command to export the .kube/config file in your home directory
aws eks update-kubeconfig --name [cluster_name] --region [region]
Example: aws eks update-kubeconfig --name eks --region us-east-1


https://peiruwang.medium.com/eks-exposing-service-with-external-dns-3be8facc73b9


```
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy_latest.json

#iam_policy_latest.json
#arn:aws:iam::788210522308:policy/AWSLoadBalancerControllerIAMPolicy


eksctl create iamserviceaccount \
  --cluster=eks \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --attach-policy-arn=arn:aws:iam::788210522308:policy/AWSLoadBalancerControllerIAMPolicy \
  --override-existing-serviceaccounts \
  --approve

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=eks \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=us-east-1 \
  --set vpcId=vpc-0166ef20607f16987 \
  --set image.repository=602401143452.dkr.ecr.us-east-1.amazonaws.com/amazon/aws-load-balancer-controller
```