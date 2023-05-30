module "users" {
  source = "../../../modules/iam_users"
  environment = var.environment
  iam_users = local.iam_users
}
