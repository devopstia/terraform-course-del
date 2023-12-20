## Authentication with Azure CLI
https://jeffbrown.tech/terraform-azure-authentication/

## Create SSH Keys for Azure Linux VM
```t
# Create Folder
mkdir ssh-keys

# Create SSH Key
cd ssh-ekys
ssh-keygen \
    -m PEM \
    -t rsa \
    -b 4096 \
    -C "azureuser@devopseasylearning" \
    -f learning-terraform-azure.pem 
Important Note: If you give passphrase during generation, during everytime you login to VM, you also need to provide passphrase.


# List Files
ls -lrt ssh-keys/

# Files Generated after above command 
Public Key: learning-terraform-azure.pem.pub -> Rename as learning-terraform-azure.pub
Private Key: learning-terraform-azure.pem

# upload the public key to azure or add the key while creating an instance
- a private key will be used to connect

# Permissions for Pem file
chmod 400 learning-terraform-azure.pem

# Connect to VM and Verify 
ssh -i ssh-keys/learning-terraform-azure.pem azureuser@<PUBLIC-IP>
``` 