
resource "aws_ecr_repository" "container_repository" {
  name = var.ecr_respository_name
  tags = {
    Owner    = "alpha"
    CreateBy = "Terraform"
  }
}

resource "aws_ecr_lifecycle_policy" "default-retention-number-policy" {
  repository = aws_ecr_repository.container_repository.name

  policy = <<EOF
{
   "rules": [
       {
           "rulePriority": 1,
           "description": "Keep only ${var.max_number_to_keep} In ECR repository",
           "selection": {
               "tagStatus": "any",
               "countType": "imageCountMoreThan",
               "countNumber": ${var.max_number_to_keep}
           },
           "action": {
               "type": "expire"
           }
       }
   ]
}
EOF
}




