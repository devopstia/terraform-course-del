### List databases
```
\l
```
### Quit
```
\q
```

### List table
```
\dt
```

### List users
```
\du
```

### Clear screen
```
\! cls
```

### Switching Databases
```
\c [database name]
\c sales
```

### Create a database
```sql
CREATE DATABASE [database name];
CREATE DATABASE sales;
```

### PostgreSQL DROP DATABASE
**NB:** only the supper user and the owner can drop the database
```sql
DROP DATABASE IF EXISTS  [database name];
DROP DATABASE IF EXISTS sales;
```

### How to delete users?
```sql
DROP USER  [user name];
DROP USER  tia;
```

### Drop a table
```sql
DROP TABLE  [table name];
DROP TABLE accounts;
```

### Create a database and connect
```sql
CREATE DATABASE hr;
CREATE USER john WITH ENCRYPTED PASSWORD '12345';
GRANT ALL PRIVILEGES ON DATABASE hr TO john;

psql -h artifactory.devopseasylearning.net -p 5432 -U john -W -d hr 
```

## run sql script
```sh
psql -h artifactory.devopseasylearning.net -p 5432 -U john -W -d hr < /root/hr.sql
psql -h artifactory.devopseasylearning.net -p 5432 -U john -W -d hr < /root/contacts.sql

## list table
\dt
```

### Search in the table
```
SELECT * FROM [table name];
SELECT * FROM contacts_docs;
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM job_history;
SELECT * FROM jobs;
SELECT * FROM locations;
SELECT * FROM regions;
```


