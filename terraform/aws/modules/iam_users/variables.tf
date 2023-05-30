variable "environment" {
  type = string
  description = "Name of the environment (development, production, etc)."
}

variable "iam_users" {
  type = list(map(any))
  description = "List of IAM users (maps) to create."
}
