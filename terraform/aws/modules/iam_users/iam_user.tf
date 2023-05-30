resource "aws_iam_user" "this" {
  for_each = {
    for i, user in var.iam_users : user.name => user
  }
  name = "${each.value.name}-${var.environment}"
}

resource "aws_iam_user_policy" "this" {
  for_each = {
    for i, user in var.iam_users : user.name => user
  }
  name       = "${each.value.name}-${var.environment}"
  user       = "${each.value.name}-${var.environment}"
  policy     = each.value.policy
  depends_on = [aws_iam_user.this]
}

resource "aws_iam_access_key" "access_key" {
  for_each = {
    for i, user in var.iam_users : user.name => user
  }
  user       = "${each.value.name}-${var.environment}"
  depends_on = [aws_iam_user.this]
}

resource "aws_ssm_parameter" "access_key_id" {
  for_each = {
    for i, user in var.iam_users : user.name => user
  }
  name       = "/${var.environment}/${each.value.name}/access-key-id"
  type       = "String"  # using String because it's totally free, better to use encryption
  value      = aws_iam_access_key.access_key["${each.value.name}"].id
  depends_on = [aws_iam_access_key.access_key]
}

resource "aws_ssm_parameter" "secret_access_key" {
  for_each = {
    for i, user in var.iam_users : user.name => user
  }
  name       = "/${var.environment}/${each.value.name}/secret-access-key"
  type       = "String"  # using String because it's totally free, better to use encryption
  value      = aws_iam_access_key.access_key["${each.value.name}"].secret
  depends_on = [aws_iam_access_key.access_key]
}
