# aks-controle-plane

## Call get-versions API via command line
```
az aks get-versions --location centralus -o table
```

## Create SSH Key
```
ssh-keygen \
    -m PEM \
    -t rsa \
    -b 4096 \
    -C "azureuser@terraform" \
    -f ./azure-terraform
```