## ingress-nginx
```sh
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm fetch ingress-nginx/ingress-nginx --untar

kubectl create ns ingress-nginx-controller
helm upgrade ingress-nginx --install ../charts/ingress-nginx --values ingress-nginx.yaml --namespace ingress-nginx-controller

helm uninstall ingress-nginx


helm install ingress-nginx ingress-nginx/ingress-nginx \
    --namespace ingress-nginx-controller \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux \
    --set controller.service.externalTrafficPolicy=Local    
```

```sh
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm fetch ingress-nginx/ingress-nginx --untar

kubectl create ns ingress-nginx
helm upgrade ingress-nginx --install ../charts/ingress-nginx --values ingress-nginx.yaml --namespace ingress-nginx

helm uninstall ingress-nginx


helm install ingress-nginx ingress-nginx/ingress-nginx \
    --namespace ingress-nginx \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux \
    --set controller.service.externalTrafficPolicy=Local
```


## Install Cert Manager
```t
# Label the nginx-ingress-controller namespace to disable resource validation
kubectl label namespace nginx-ingress-controller cert-manager.io/disable-validation=true

helm repo add jetstack https://charts.jetstack.io
helm repo update
helm fetch jetstack/cert-manager --untar

kubectl create ns cert-manager
helm upgrade cert-manager --install ../charts/cert-manager --values cert-manager.yaml --namespace cert-manager


