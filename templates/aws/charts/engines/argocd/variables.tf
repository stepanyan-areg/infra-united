# General
variable "release_name" {
  type        = string
  description = "Name of release"
}
variable "region" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "chart_name" {
  type        = string
  description = "Name of the chart to install"
  default     = "argo-cd"
}
variable "chart_version" {
  type        = string
  description = "Version of the chart to install"
  default     = "7.3.11"
}
variable "repository" {
  type        = string
  description = "Repository to install the chart from"
  default     = "https://argoproj.github.io/argo-helm"
}
variable "namespace" {
  type        = string
  description = "Namespace to install the chart into"
}
variable "serviceaccount" {
  type        = string
  description = "Serviceaccount name to install the chart into"
  default     = "argocd"
}
variable "extra_values" {
  type        = map(any)
  description = "Extra values in key value format"
  default     = {}
}
variable "create_namespace" {
  type        = bool
  description = "Create the namespace if it does not exist"
  default     = true
}
variable "recreate_pods" {
  type        = bool
  description = "Recreate pods in the deployment if necessary"
  default     = true
}
variable "timeout" {
  type        = number
  description = "Timeout for the helm release"
  default     = 3000
}
variable "hostname" {
  type        = string
  description = "Hostname of argocd"
}
variable "ingress_group_name" {
  type        = string
  default     = ""
  description = "Reuse same ALB by specifying the same ALB group name"
}

# ECR registry
variable "ecr_reg_enabled" {
  type        = bool
  description = "Whether sync ArgoCD to ECR registry"
  default     = false
}
variable "eks_oidc_issuer_url" {
  type        = string
  description = "eks_oidc_issuer_url"
}

# GitOps repository
variable "gitops_repo_enabled" {
  type        = bool
  description = "Whether sync ArgoCD to GitOps repository"
  default     = false
}
variable "github_org_name" {
  type        = string
  description = "GitOps repository organization"
  default     = ""
}
variable "github_repo_name" {
  type        = string
  description = "GitOps repository name"
  default     = "gitops"
}
variable "gitops_apps_dir_path" {
  type        = string
  description = "Path to all application Yamls in GitOps repository"
  default     = "apps"
}

# Microservices repositories
variable "github_connect_repositories_enabled" {
  type        = bool
  description = "Connect repositories to ArgoCD"
  default     = false
}
variable "github_repositories_name" {
  type    = list(string)
  default = []
}

# ArgoCD GitHub SSO
variable "sso_enabled" {
  type        = bool
  description = "Whether to use ArgoCD SSO"
  default     = false
}
variable "sso_org" {
  type        = string
  description = "SSO organization"
  default     = ""
}
variable "github_admins_team" {
  type        = string
  description = "Name of ArgoCD admins-team on GitHub"
  default     = "argocd-admins"
}
variable "awssm_secret_name" {
  type        = string
  description = "Name of AWSSM secret"
}
variable "argocd_github_sso_secret" {
  type        = string
  description = "Name of secret contains GitHub app credentials"
}
variable "external_secrets_namespace" {
  type        = string
  description = "External-Secrets namespace"
  default     = "kube-system"
}
variable "external_secrets_serviceaccount" {
  type        = string
  description = "Service Account name"
  default     = "external-secrets"
}

# Argo-Workflows GitHub SSO
variable "argo_workflows_sso_enabled" {
  type        = bool
  default     = false
  description = "Whether to add argo-workflows to argocd dex"
}
variable "argo_workflows_hostname" {
  type        = string
  description = "Argo-Workflows hostname"
}
variable "argo_workflows_namespace" {
  type        = string
  description = "Argo-Workflows namespace"
}

# Argo-Rollouts Extension for ArgoCD
variable "argo_rollouts_extension_enable" {
  type        = bool
  default     = false
  description = "Whether to install Argo-Rollouts extension for ArgoCD"
}
variable "extension_url" {
  type        = string
  default     = "https://github.com/argoproj-labs/rollout-extension/releases/download/v0.3.5/extension.tar"
  description = "Argo-Rollouts extension package"
}

variable "has_dedicated_infra_nodes" {
  type        = bool
  default     = false
  description = "If enabled, components will be deployed on dedicated nodes with label role:infra"
}
