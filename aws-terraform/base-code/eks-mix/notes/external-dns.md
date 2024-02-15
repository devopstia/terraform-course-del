## IAM Policy
**References**
- https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/alb-ingress.md
- https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/aws.md
- https://aws.amazon.com/premiumsupport/knowledge-center/eks-set-up-externaldns/


## Create this policy first in AWS
```json
// AllowExternalDNSUpdates
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "arn:aws:route53:::hostedzone/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
```

## IAM Role, k8s Service Account & Associate IAM Policy
```sh
kubectl create ns external-dns
# Template
eksctl create iamserviceaccount \
    --name service_account_name \
    --namespace service_account_namespace \
    --cluster cluster_name \
    --attach-policy-arn IAM_policy_ARN \
    --approve \
    --override-existing-serviceaccounts

# Replaced name, namespace, cluster, IAM Policy arn 
eksctl create iamserviceaccount \
    --name external-dns \
    --namespace external-dns \
    --cluster eks \
    --attach-policy-arn arn:aws:iam::788210522308:policy/AllowExternalDNSUpdates \
    --approve \
    --override-existing-serviceaccounts
```

## Describe Service Account
kubectl describe sa external-dns
Observation: 
1. Verify the Annotations and you should see the IAM Role is present on the Service Account

List IAM Service Accounts using eksctl
eksctl get iamserviceaccount --cluster eks

## Issues: failed to sync v1.Ingress: context deadline exceeded
```
time="2021-11-01T10:55:49Z" level=info msg="Instantiating new Kubernetes client"
time="2021-11-01T10:55:49Z" level=debug msg="apiServerURL: "
time="2021-11-01T10:55:49Z" level=debug msg="kubeConfig: "
time="2021-11-01T10:55:49Z" level=info msg="Using inCluster-config based on serviceaccount-token"
time="2021-11-01T10:55:49Z" level=info msg="Created Kubernetes client https://172.20.0.1:443"
time="2021-11-01T10:56:49Z" level=fatal msg="failed to sync *v1.Ingress: context deadline exceeded"
```
https://github.com/kubernetes-sigs/external-dns/issues/2407

I had the same error and turned out I had the wrong namespace default in ClusterRoleBinding whereas I had deployed external-dns in its own namespace. Changing the namespace in the ClusterRoleBinding fixed it for me.

## External DNS Kubernetes manifest
- https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/alb-ingress.md
- https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/aws.md

## vim external-dns
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: external-dns
  # If you're using Amazon EKS with IAM Roles for Service Accounts, specify the following annotation.
  # Otherwise, you may safely omit it.
  annotations:
    # Replace with your IAM ARN Role for extern-dns in AMI
    # The service account create with eksctl create iamserviceaccount will create an AMI role
    eks.amazonaws.com/role-arn: arn:aws:iam::788210522308:role/eksctl-eks-addon-iamserviceaccount-external-Role1-1IU8CEVFV1K4S
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: external-dns
rules:
  - apiGroups: [""]
    resources: ["services"]
    verbs: ["get","watch","list"]
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get","watch","list"]
  - apiGroups: ["networking","networking.k8s.io"]
    resources: ["ingresses"]
    verbs: ["get","watch","list"]
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["get","watch","list"]
  - apiGroups: [""]
    resources: ["endpoints"]
    verbs: ["get","watch","list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: external-dns-viewer
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: external-dns
subjects:
- kind: ServiceAccount
  name: external-dns
  namespace: external-dns
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: external-dns
spec:
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: external-dns
  template:
    metadata:
      labels:
        app: external-dns
      # If you're using kiam or kube2iam, specify the following annotation.
      # Otherwise, you may safely omit it.  #Change-2: Commented line 55 and 56
      #annotations:  
        #iam.amazonaws.com/role: arn:aws:iam::ACCOUNT-ID:role/IAM-SERVICE-ROLE-NAME    
    spec:
      serviceAccountName: external-dns
      containers:
      - name: external-dns
        # https://github.com/kubernetes-sigs/external-dns/releases
        image: k8s.gcr.io/external-dns/external-dns:v0.10.2
        args:
        - --source=service
        - --source=ingress
        # - --domain-filter=devopseasylearning.net # will make ExternalDNS see only the hosted zones matching provided domain, omit to process all available hosted zones. if commented out, external dns will be able to create record in all domains in route50
        - --provider=aws
        # - --policy=upsert-only # would prevent ExternalDNS from deleting any records, omit to enable full synchronization. if commented out, the record will be deleted automatically when you delete the external dns
        - --aws-zone-type=public # only look at public hosted zones (valid values are public, private or no value for both)
        - --registry=txt
        - --txt-owner-id=my-hostedzone-identifier
      securityContext:
        fsGroup: 65534 # For ExternalDNS to be able to read Kubernetes and AWS token files. PS external will not works if this is no enable
```





## Ingress
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress-external-dns
  labels:
    app: app-ingress
  annotations:
    kubernetes.io/ingress.class: "alb" 
    alb.ingress.kubernetes.io/load-balancer-name: external-dns-ingress
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
    alb.ingress.kubernetes.io/healthcheck-protocol: HTTP 
    # Heath check settings
    # alb.ingress.kubernetes.io/healthcheck-port: '80'
    alb.ingress.kubernetes.io/healthcheck-port: traffic-port  
    alb.ingress.kubernetes.io/healthcheck-interval-seconds: '15'
    alb.ingress.kubernetes.io/healthcheck-timeout-seconds: '5'
    alb.ingress.kubernetes.io/success-codes: '200'
    alb.ingress.kubernetes.io/healthy-threshold-count: '2'
    alb.ingress.kubernetes.io/unhealthy-threshold-count: '2'
    # SSH settings
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS":443}, {"HTTP":80}]'
    alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:us-east-1:788210522308:certificate/c3eebb6d-52d1-47d2-88f9-032c8fa3652a
    # SSL Redirect Setting (http to https) all http will be redirected to https
    alb.ingress.kubernetes.io/ssl-redirect: '443'
    # External dns settings
    external-dns.alpha.kubernetes.io/hostname: dev.devopseasylearning.net, stg.devopseasylearning.net

spec:
    rules:
      - http:
          paths:
            - path: /covid19
              pathType: Prefix
              backend:
                service:
                  name: covid19-nodeport-service
                  port:
                    number: 80  
            - path: /halloween
              pathType: Prefix
              backend:
                service:
                  name: halloween-nodeport-service
                  port:
                    number: 80
            - path: /phone
              pathType: Prefix
              backend:
                service:
                  name: phone-nodeport-service
                  port:
                    number: 80
            - path: /static
              pathType: Prefix
              backend:
                service:
                  name: static-nodeport-service
                  port:
                    number: 80
            - path: /website
              pathType: Prefix
              backend:
                service:
                  name: website-nodeport-service
                  port:
                    number: 80
            - path: /
              pathType: Prefix
              backend:
                service:
                  name: articles-nodeport-service
                  port:
                    number: 80
```

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress-external-dns
  labels:
    app: app-ingress
  annotations:
    kubernetes.io/ingress.class: "alb" 
    alb.ingress.kubernetes.io/load-balancer-name: external-dns-ingress
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/target-type: ip
    alb.ingress.kubernetes.io/healthcheck-protocol: HTTP 
    # Heath check settings
    # alb.ingress.kubernetes.io/healthcheck-port: '80'
    alb.ingress.kubernetes.io/healthcheck-port: traffic-port  
    alb.ingress.kubernetes.io/healthcheck-interval-seconds: '15'
    alb.ingress.kubernetes.io/healthcheck-timeout-seconds: '5'
    alb.ingress.kubernetes.io/success-codes: '200'
    alb.ingress.kubernetes.io/healthy-threshold-count: '2'
    alb.ingress.kubernetes.io/unhealthy-threshold-count: '2'
    # SSH settings
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS":443}, {"HTTP":80}]'
    alb.ingress.kubernetes.io/certificate-arn: arn:aws:acm:us-east-1:788210522308:certificate/c3eebb6d-52d1-47d2-88f9-032c8fa3652a
    # SSL Redirect Setting (http to https) all http will be redirected to https
    alb.ingress.kubernetes.io/ssl-redirect: '443'
    # External dns settings
    external-dns.alpha.kubernetes.io/hostname: articles.devopseasylearning.net, dev.devopseasylearning.net
spec:
  defaultBackend:
    service:
      name: articles-nodeport-service
      port:
        number: 80
  rules: 
    - host: covid19.devopseasylearning.net
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: covid19-nodeport-service
                port: 
                  number: 80
    - host: creative.devopseasylearning.net
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: creative-nodeport-service
                port: 
                  number: 80
    - host: halloween.devopseasylearning.net
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: halloween-nodeport-service
                port: 
                  number: 80
    - host: phone.devopseasylearning.net
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: phone-nodeport-service
                port: 
                  number: 80
    - host: static.devopseasylearning.net
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: static-nodeport-service
                port: 
                  number: 80
    - host: website.devopseasylearning.net
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: website-nodeport-service
                port: 
                  number: 80
   
```