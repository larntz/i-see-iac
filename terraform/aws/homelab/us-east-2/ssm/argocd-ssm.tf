resource "aws_ssm_parameter" "argocd_repo_url" {
  name       = "/${var.environment}/argocd/repo-url"
  type       = "String"  # using String because it's totally free, better to use encryption
  value      = var.argocd_repo_url
}

resource "aws_ssm_parameter" "argocd_repo_ssh_key" {
  name       = "/${var.environment}/argocd/repo-sshPrivateKey"
  type       = "String"  # using String because it's totally free, better to use encryption
  value      = file(var.argocd_repo_ssh_key)
}
