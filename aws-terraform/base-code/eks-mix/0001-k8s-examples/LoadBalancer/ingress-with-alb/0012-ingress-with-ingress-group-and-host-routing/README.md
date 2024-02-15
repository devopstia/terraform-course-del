##  IngressGroup feature
- IngressGroup feature enables you to group multiple Ingress resources together.
The controller will automatically merge Ingress rules for all Ingresses within IngressGroup and support them with a single ALB.
- In addition, most annotations defined on a Ingress only applies to the paths defined by that Ingress.

## Recursuve apply
```
kubectl apply -R  -f 0012-ingress-with-ingress-group-and-host-routing -n dev 
kubectl delete -R -f  0012-ingress-with-ingress-group-and-host-routing -n dev 
```

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