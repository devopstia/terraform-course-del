## Login and check users that sign up already as root
```sh
kubectl exec -it pod_name  /bin/bash
kubectl exec -it alpha-db-xyz123  /bin/bash
mysql -u root -p

SHOW DATABASES;
USE auth;
SHOW TABLES;
SELECT * FROM users;
```