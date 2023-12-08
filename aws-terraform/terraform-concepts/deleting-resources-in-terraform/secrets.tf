variable "aws-secret-string" {
  type = list(string)
  default = [
    "jenkins",
    "splunk_key",
    "argocd",
    "aws-key",
    "elk-key"
  ]
}

resource "aws_secretsmanager_secret" "example" {
  count                   = length(var.aws-secret-string)
  name                    = var.aws-secret-string[count.index]
  recovery_window_in_days = 0
  tags = {
    "Terraform" = "true"
    "Project"   = "DEL"
  }
}
