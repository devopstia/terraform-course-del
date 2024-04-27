# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# echo "Deploying the resource groups module"
# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# sleep 3
# cd resources/resource-group
# terraform init
# terraform fmt
# terraform apply --auto-approve
# cd -


# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# echo "Deploying the storage account backend module"
# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# sleep 3
# cd resources/storage-backend
# terraform init
# terraform fmt
# terraform apply --auto-approve
# cd -


# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# echo "Deploying the AKS module"
# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# sleep 3
# cd modules/aks-controle-plane
# terraform init
# terraform fmt
# terraform apply --auto-approve
# cd -

# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# echo "Export the kubeconfig"
# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# sleep 3
# az aks get-credentials --resource-group 2560-dev-del-rg --name 2560-dev-del-aks --overwrite-existing --file ~/.kube/config


# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# echo "Deploying Ingress Nginx Controller"
# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# sleep 3

# # helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
# # helm repo update
# # helm fetch ingress-nginx/ingress-nginx --untar

# cd aks-resources/helm/values
# kubectl create ns nginx-ingress-controller || true
# helm upgrade nginx-ingress-controller --install ../charts/nginx-ingress-controller --values nginx-ingress-controller.yaml --namespace nginx-ingress-controller
# cd -


echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
echo "Deploying Cert Manager"
echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
sleep 3

# helm repo add jetstack https://charts.jetstack.io
# helm repo update
# helm fetch jetstack/cert-manager --untar

kubectl label namespace nginx-ingress-controller cert-manager.io/disable-validation=true
cd aks-resources/helm/values
kubectl create ns cert-manager || true
helm upgrade cert-manager --install ../charts/cert-manager --values cert-manager.yaml --namespace cert-manager
cd -


# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# echo "Deploying External DNS"
# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# sleep 3
# cd aks-resources/external-dns
# kubectl create namespace external-dns || true
# kubectl create secret generic azure-config-file -n external-dns --from-file azure.json
# kubectl apply -f external-dns.yaml -n external-dns
# cd -


# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# echo "Deploying a test app for External DNS"
# echo "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
# sleep 3
# cd aks-resources/external-dns
# kubectl create namespace app || true
# kubectl apply -f app-test.yaml -n app
# cd -
# # kubectl delete -f app-test.yaml -n app