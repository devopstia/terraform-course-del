## Ansible Vault
```sh
ansible-vault encrypt --vault-password-file=path/to/vault_password_file <file_name>

ansible-vault encrypt --vault-password-file=/path/to/vault_password_file secret_file.yml


ansible-vault encrypt --vault-password-file=./vault_password_file.txt azure.json
ansible-vault encrypt --vault-password-file=./vault_password_file.txt README.md

ansible-vault decrypt --vault-password-file=./vault_password_file.txt azure.json
ansible-vault decrypt --vault-password-file=./vault_password_file.txt README.md
```