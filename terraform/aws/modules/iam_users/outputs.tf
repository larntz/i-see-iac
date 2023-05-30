output "iam_users" {
  value = values(aws_iam_user.this)[*].arn
}
