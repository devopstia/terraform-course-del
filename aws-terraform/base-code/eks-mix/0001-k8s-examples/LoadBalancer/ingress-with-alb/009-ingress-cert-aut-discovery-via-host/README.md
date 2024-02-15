## ingress-cert-aut-discovery-via-host
- Automatically disover SSL Certificate from AWS Certificate Manager Service using spec.rules.host
- In this approach, with the specified domain name if we have the SSL Certificate created in AWS Certificate Manager, that certificate will be automatically detected and associated to Application Load Balancer.
- We don't need to get the SSL Certificate ARN and update it in Kubernetes Ingress Manifest
- Discovers via Ingress rule host and attaches a cert for *.devopseasylearning.net to the ALB

## URL
```
dev.devopseasylearning.net/

https://articles.devopseasylearning.net/

https://covid19.devopseasylearning.net/

https://creative.devopseasylearning.net/

https://halloween.devopseasylearning.net/

https://phone.devopseasylearning.net/

https://static.devopseasylearning.net/

https://website.devopseasylearning.net/
```