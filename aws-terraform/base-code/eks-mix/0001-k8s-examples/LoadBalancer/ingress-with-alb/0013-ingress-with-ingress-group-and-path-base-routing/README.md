##  IngressGroup feature
- IngressGroup feature enables you to group multiple Ingress resources together.
The controller will automatically merge Ingress rules for all Ingresses within IngressGroup and support them with a single ALB.
- In addition, most annotations defined on a Ingress only applies to the paths defined by that Ingress.

## Recursuve apply
```
kubectl apply -R  -f 0013-ingress-with-ingress-group-and-path-base-routing -n dev 
kubectl delete -R -f  0013-ingress-with-ingress-group-and-path-base-routing -n dev 
```

## URL
```
dev.devopseasylearning.net/

dev.devopseasylearning.net/covid19

dev.devopseasylearning.net/creative

dev.devopseasylearning.net/halloween

dev.devopseasylearning.net/phone

dev.devopseasylearning.net/static

dev.devopseasylearning.net/website
```