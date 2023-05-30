variable "environment" {
  description = "Name of the environment."
  type = string
}

variable "argocd_repo_url" {
  description = "Git URL for ArgoCD workload repository."
  type = string
}

variable "argocd_repo_ssh_key" {
  description = "Filesystem path to the repo deploy key (must also be added to GitHub repo)."
  type = string
}
