## Create SSH Keys for Azure Linux VM
```t
# Create Folder
cd terraform-manifests/
mkdir ssh-keys

# Create SSH Key
cd ssh-ekys
ssh-keygen \
    -m PEM \
    -t rsa \
    -b 4096 \
    -C "azureuser@myserver" \
    -f terraform-azure.pem 
Important Note: If you give passphrase during generation, during everytime you login to VM, you also need to provide passphrase.

cd ssh-ekys
ssh-keygen \
    -m PEM \
    -t rsa \
    -b 4096 \
    -C "s7tia@myserver" \
    -f terraform-azure.pem 
Important Note: If you give passphrase during generation, during everytime you login to VM, you also need to provide passphrase.

# List Files
ls -lrt ssh-keys/

# Files Generated after above command 
Public Key: terraform-azure.pem.pub -> Rename as terraform-azure.pub
Private Key: terraform-azure.pem

# Permissions for Pem file
chmod 400 terraform-azure.pem
``` 

## Notes
-f terraform-azure.pem: This option specifies the file name for the private key file. The private key will be saved in a file named "terraform-azure.pem" in the current directory.
-C "azureuser@myserver": This option is used to add a comment to the key. In this case, the comment is set to "azureuser@myserver" to help identify the purpose or user associated with the key (the default user is azureuser while creating azure vms)
-b 4096: This option specifies the key length, which is set to 4096 bits. A longer key length generally provides stronger security but also requires more computational resources.