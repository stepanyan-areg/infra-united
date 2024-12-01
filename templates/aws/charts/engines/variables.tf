# General
variable "region" {
  type = string
}
variable "cluster_name" {
  type = string
}
# variable "cluster_oidc_provider" {
#   type = string
# }
# variable "vpc_id" {
#   type = string
# }
variable "domain_name" {
  type = string
}
# variable "acm_certificate_arn" {
#   type = string
# }

# Jenkins server
# variable "jenkins_enabled" {
#   type    = bool
#   default = false
# }
# variable "jenkins_namespace" {
#   type    = string
#   default = "jenkins"
# }
# variable "jenkins_serviceaccount" {
#   type    = string
#   default = "jenkins"
# }

## Apache Airflow
# variable "airflow_enabled" {
#   type    = bool
#   default = false
# }
# variable "airflow_namespace" {
#   type    = string
#   default = "airflow"
# }
# variable "airflow_serviceaccount" {
#   type    = string
#   default = "airflow"
# }

## GitHub Actions Runners Controller
variable "github_actions_runner_controller_enabled" {
  type    = bool
  default = false
}
# variable "github_runner_serviceaccount" {
#   type    = string
#   default = "actions-runner-system"
# }
# variable "github_runners_extra_values" {
#   type    = map(any)
#   default = {}
# }
# variable "github_token" {
#   type    = string
#   default = ""
# }
# variable "github_token_ssm_parameter" {
#   type    = string
#   default = ""
# }
# variable "github_runner_reg_url" {
#   type    = string
#   default = ""
# }
# variable "github_webhook_server_enabled" {
#   type    = bool
#   default = false
# }
# variable "github_webhook_server_host" {
#   type    = string
#   default = ""
# }
# variable "github_webhook_server_path" {
#   type    = string
#   default = "/"
# }
# variable "github_webhook_server_secret_enabled" {
#   type    = bool
#   default = false
# }
# variable "github_runners_deploy_list" {
#   type = list(object({
#     name          = optional(string)
#     repository    = optional(string)
#     limits_cpu    = optional(string)
#     limits_memory = optional(string)
#     replicas_min  = optional(number)
#     replicas_max  = optional(number)
#   }))
#   default = []
# }

#ArgoCD
variable "argocd_release_name" {
  type        = string
  description = "Name of release"
  default     = "argocd"
}
variable "argocd_enabled" {
  type    = bool
  default = false
}
variable "argocd_namespace" {
  type        = string
  description = "Namespace to install the chart into"
  default     = "argocd"
}

variable "argocd_ingress_group_name" {
  type    = string
  default = ""
}

# GitOps repository
variable "gitops_repo_enabled" {
  type        = bool
  description = "Whether sync ArgoCD to GitOps repository"
  default     = false
}
variable "github_org_name" {
  type        = string
  description = "GitHub organization"
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
  default     = ""
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

# ArgoCD GitHub SSO
variable "argocd_sso_enabled" {
  type        = bool
  description = "Whether to use ArgoCD SSO"
  default     = false
}
variable "argocd_sso_org" {
  type        = string
  description = "SSO organization"
  default     = ""
}
variable "argocd_github_admins_team" {
  type        = string
  description = "Name of ArgoCD admins-team on GitHub"
  default     = "argocd-admins"
}
variable "argocd_github_sso_secret" {
  type        = string
  description = "Name of secret contains GitHub app credentials"
  default     = "argocd-github-sso"
}
variable "awssm_secret_name" {
  type        = string
  description = "Name of AWSSM secret"
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

# Argo-Rollouts Extension for ArgoCD
variable "argo_rollouts_extension_enable" {
  type        = bool
  default     = false
  description = "Whether to install Argo-Rollouts extension for ArgoCD"
}

## Argo Workflows
variable "argo_workflows_enabled" {
  type    = bool
  default = false
}
variable "argo_workflows_namespace" {
  type    = string
  default = "argo"
}
variable "argo_workflows_release_name" {
  type        = string
  default     = "argo-workflows"
  description = "Release name of argo-workflows"
}
variable "argo_workflows_sso_enabled" {
  type    = bool
  default = false
}

## Argo Rollouts

# variable "argo_rollouts_enabled" {
#   type    = bool
#   default = false
# }
# variable "argo_rollouts_dashboard_enabled" {
#   type        = bool
#   default     = true
#   description = "Enable Argo-Rollouts dashboard ui"
# }
# variable "argo_rollouts_namespace" {
#   type    = string
#   default = "argo-rollouts"
# }
# variable "argo_rollouts_customized_demo_enabled" {
#   type = bool
#   description = "Create your own customize rollouts demo"
#   default = false
# }
# variable "argo_rollouts_traffic_light_demo_enabled" {
#   type = bool
#   description = "Create traffic_light rollouts demo"
#   default = false
# }

variable "has_dedicated_infra_nodes" {
  type        = bool
  default     = false
  description = "If enabled, components will be deployed on dedicated nodes with label role:infra"
}

