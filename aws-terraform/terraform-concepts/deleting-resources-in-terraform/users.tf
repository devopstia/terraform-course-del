variable "user_names" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["user1", "user2", "user3"]
}
resource "aws_iam_user" "user1" {
  name = var.user_names[0]
}
resource "aws_iam_user" "user2" {
  name = var.user_names[1]
}
resource "aws_iam_user" "user3" {
  name = var.user_names[2]
}
