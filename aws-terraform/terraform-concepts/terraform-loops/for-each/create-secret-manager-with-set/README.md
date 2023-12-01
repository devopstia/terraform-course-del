## Disable retention policy
- The default retention policy is set to 7 day. we can add recovery_window_in_days = 0  to disable it
```s
resource "aws_secretsmanager_secret" "example" {
  for_each                = toset(var.aws-secret-string)
  name                    = "${var.tags["id"]}-${var.tags["environment"]}-${var.tags["project"]}-${each.value}"
  recovery_window_in_days = 0 
  tags                    = var.tags
}
```

## Delete secret through the CLi if Disable retention policy was not disable
```
aws secretsmanager delete-secret --secret-id your-secret-name --force-delete-without-recovery --region your-region
```