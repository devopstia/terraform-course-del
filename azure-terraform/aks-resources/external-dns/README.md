## Kubernetes External DNS for Azure DNS & AKS
https://techcommunity.microsoft.com/t5/core-infrastructure-and-security/kubernetes-external-dns-for-azure-dns-amp-aks/ba-p/3809393.

PS: PLEASE USE AZURE CLOUD SHELL TO CREATE THIS.

## Set variables and create SP
DNS_ZONE_NAME="devopseasylearning.net"
DNS_ZONE_RG="2560-dev-del-dns-zone"
EXTERNALDNS_SPN_NAME="sp-external-dns-aks"

DNS_SPN=$(az ad sp create-for-rbac --name $EXTERNALDNS_SPN_NAME)
EXTERNALDNS_SPN_APP_ID=$(echo $DNS_SPN | jq -r '.appId')
EXTERNALDNS_SPN_PASSWORD=$(echo $DNS_SPN | jq -r '.password')

## fetch DNS id and RG used to grant access to the service principal
DNS_ZONE_ID=$(az network dns zone show -n $DNS_ZONE_NAME -g $DNS_ZONE_RG --query "id" -o tsv)
DNS_ZONE_RG_ID=$(az group show -g $DNS_ZONE_RG --query "id" -o tsv)

## assign reader to the resource group
az role assignment create --role "Reader" --assignee $EXTERNALDNS_SPN_APP_ID --scope $DNS_ZONE_RG_ID

## assign contributor to DNS Zone itself
az role assignment create --role "DNS Zone Contributor" --assignee $EXTERNALDNS_SPN_APP_ID --scope $DNS_ZONE_ID

## Get Service principal values
echo $DNS_SPN

## Create a Kubernetes secret for the service principal
```sh
cat <<EOF > azure.json
{
  "tenantId": "$(az account show --query tenantId -o tsv)",
  "subscriptionId": "$(az account show --query id -o tsv)",
  "resourceGroup": "$DNS_ZONE_RG",
  "aadClientId": "$EXTERNALDNS_SPN_APP_ID",
  "aadClientSecret": "$EXTERNALDNS_SPN_PASSWORD"
}
EOF
```
## Check the content
```sh
cat azure.json 
{
  "tenantId": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "subscriptionId": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "resourceGroup": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "aadClientId": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "aadClientSecret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}
```

## Deploy external DNS
```sh
cd aks-resources/external-dns
kubectl create namespace external-dns || true
kubectl create secret generic azure-config-file -n external-dns --from-file azure.json
kubectl apply -f external-dns.yaml -n external-dns
```

## aws devopseasylearning.net NS
```
ns-1789.awsdns-31.co.uk.
ns-1101.awsdns-09.org.
ns-313.awsdns-39.com.
ns-930.awsdns-52.net.
```