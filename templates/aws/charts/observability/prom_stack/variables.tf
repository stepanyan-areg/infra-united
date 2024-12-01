variable "name" {
  type        = string
  description = "Name of release"
  default     = "kube-prom-stack"
}

variable "namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "monitoring"
}

variable "chart_version" {
  type        = string
  description = "Helm chart to release"
  default     = "61.5.0"
}

variable "enabled" {
  type        = bool
  description = "Enable or not chart as a component"
  default     = false
}

variable "extra_values" {
  type        = map(any)
  description = "Extra values in key value format"
  default     = {}
}

variable "serviceaccount" {
  type        = string
  description = "Serviceaccount name"
  default     = "prom-stack"
}

variable "cluster_name" {
  type        = string
  description = "Name of EKS cluster"
}

variable "domain_name" {
  type        = string
  description = "Roure53 hosted zone name"
}

variable "ingress_enabled" {
  type        = bool
  default     = false
  description = "Enable or not ingress"
}

variable "ingress_group_name" {
  type        = string
  default     = ""
  description = "Resuse same ALB by specifying the same ALB group name"
}

variable "prometheus_server_volume_size" {
  type        = string
  default     = "20Gi"
  description = "Size of EBS volume for prometheus server"
}

variable "prometheus_alert_manager_volume_size" {
  type        = string
  default     = "5Gi"
  description = "Size of EBS volume for prometheus alert manager"
}

variable "loki_stack_datasource_enabled" {
  type        = bool
  description = "Enable Loki Grafana Datasource"
  default     = false
}

variable "loki_stack_service_port" {
  type        = number
  default     = 3100
  description = "Loki Service port"
}

variable "has_dedicated_infra_nodes" {
  type        = bool
  default     = false
  description = "If enabled, components will be deployed on dedicated nodes with label role:infra"
}

variable "github_oauth_organization" {
  type        = string
  default     = ""
  description = "Allowed organization for Github OAuth"
}

variable "github_oauth_domains" {
  type        = string
  default     = ""
  description = "Allowed domains for Github OAuth"
}

variable "grafana_sso_enabled" {
  type        = bool
  default     = false
  description = "Enable or not Github OAuth"
}

variable "grafana_admins_team" {
  type        = string
  description = "Name of Grafana admins-team on GitHub"
}

variable "awssm_sso_secret_name" {
  type        = string
  description = "Name of AWSSM secret where sso secrets are stored"
}

variable "grafana_github_sso_secret" {
  type        = string
  description = "Name of secret contains GitHub app credentials"
  default     = "grafana-github-sso"
}
variable "cluster_secret_store_ref_name" {
  type        = string
  description = "ClusterSecretStore name"
}
