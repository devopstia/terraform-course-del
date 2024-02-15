```s
username                   = data.aws_secretsmanager_secret_version.rds_username.secret_string
password                   = data.aws_secretsmanager_secret_version.rds_password.secret_string

variable "aws-secret-string" {
  type = set(string)
  default = [
    "db-password",
    "db-username"
  ]
}

resource "aws_secretsmanager_secret" "example" {
  for_each = var.aws-secret-string
  name     = each.key
  tags = {
    "Terraform" = "true"
    "Project"   = "MAM"
  }
}

# Get secret information for RDS password
data "aws_secretsmanager_secret" "rds_password" {
  name = "db-password"
}
data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = data.aws_secretsmanager_secret.rds_password.id
}

# Get secret information for RDS username
data "aws_secretsmanager_secret" "rds_username" {
  name = "db-username"
}
data "aws_secretsmanager_secret_version" "rds_username" {
  secret_id = data.aws_secretsmanager_secret.rds_username.id
}
```


#### How can I immediately delete a Secrets Manager secret so that I can create a new secret with the same name?

- [Use the AWS Secrets Manager console to get the deleted Secrets Manager secret ID](https://aws.amazon.com/premiumsupport/knowledge-center/delete-secrets-manager-secret/#:~:text=Open%20the%20Secrets%20Manager%20console,switch%2C%20and%20then%20choose%20Save.)

#### Delete a secret
https://docs.aws.amazon.com/secretsmanager/latest/userguide/manage_delete-secret.html
```
aws secretsmanager delete-secret --secret-id sonar --force-delete-without-recovery --region us-east-1
aws secretsmanager delete-secret --secret-id splunk_key --force-delete-without-recovery --region us-east-1
aws secretsmanager delete-secret --secret-id datadog --force-delete-without-recovery --region us-east-1
aws secretsmanager delete-secret --secret-id argocd --force-delete-without-recovery --region us-east-1
aws secretsmanager delete-secret --secret-id aws-key --force-delete-without-recovery --region us-east-1
```

```s
provider "aws" {
  region = "us-east-1"
}

# variable "aws-secret-string" {
#   type = list(string)
#   default = [
#     # "jenkins",
#     "splunk_key",
#     "argocd",
#     "aws-key",
#     "elk-key"
#   ]
# }

# resource "aws_secretsmanager_secret" "example" {
#   count = length(var.aws-secret-string)
#   name  = var.aws-secret-string[count.index]
#   tags = {
#     "Terraform" = "true"
#     "Project"   = "MAM"
#   }
# }




variable "aws-secret-string" {
  type = set(string)
  default = [
    "jenkins",
    "splunk_key",
    "aws-key",
    "elk-key"
  ]
}

resource "aws_secretsmanager_secret" "example" {
  for_each = var.aws-secret-string
  name     = each.tia
  tags = {
    "Terraform" = "true"
    "Project"   = "MAM"
  }
}


# Get secret information for RDS password
data "aws_secretsmanager_secret" "rds_password" {
  name = format("%s-%s-artifactory-db-password", var.common_tags["Environment"], var.common_tags["Project"])
}
data "aws_secretsmanager_secret_version" "rds_password" {
  secret_id = data.aws_secretsmanager_secret.rds_password.id
}

# Get secret information for RDS username
data "aws_secretsmanager_secret" "rds_username" {
  name = format("%s-%s-artifactory-db-username", var.common_tags["Environment"], var.common_tags["Project"])
}
data "aws_secretsmanager_secret_version" "rds_username" {
  secret_id = data.aws_secretsmanager_secret.rds_username.id
}
```