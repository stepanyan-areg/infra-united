variable "create_github_repo" {
  type        = bool
  description = "Creare a new GitOps repository"
}

variable "github_org_name" {
  type        = string
  description = "GitOps repository organization"
  default     = ""
}

variable "github_repo_name" {
  type        = string
  description = "Organization of GitOps repository"
  default     = "gitops"
}

variable "gitops_main_branch" {
  type        = string
  description = "GitOps repository main branch"
  default     = "main"
}

variable "gitops_apps_dir_path" {
  type        = string
  description = "Path to all application Yamls in GitOps repository"
  default     = "./"
}

variable "namespace" {
  type        = string
  description = "ArgoCD namespace"
  default     = "argocd"
}

variable "github_ssh_public_key_name" {
  type        = string
  description = "Deploy key name on GitHub, where the public key is stored"
  default     = "argocd"
}

variable "app_proj_name" {
  type        = string
  description = "name of argocd application project"
  default     = "main-proj"
}