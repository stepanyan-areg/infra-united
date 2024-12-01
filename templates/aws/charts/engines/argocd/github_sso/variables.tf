variable "region" {
  type = string
}

variable "namespace" {
  type = string
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