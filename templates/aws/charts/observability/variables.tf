## Common variables
variable "cluster_name" {
  type = string
}
variable "domain_name" {
  type = string
}

# loki_stack
variable "loki_stack_enabled" {
  type    = bool
  default = true
}
variable "loki_stack_namespace" {
  type    = string
  default = "monitoring"
}

variable "loki_stack_loki_volume_size" {
  type    = string
  default = "20Gi"
}

variable "loki_stack_service_port" {
  type    = number
  default = 3100
}

# prom_stack
variable "prom_stack_enabled" {
  type    = bool
  default = true
}
variable "prom_stack_namespace" {
  type    = string
  default = "monitoring"
}
variable "prom_stack_serviceaccount" {
  type    = string
  default = "prom-stack"
}

variable "prom_stack_ingress_enabled" {
  type    = bool
  default = false
}

variable "prom_stack_ingress_group_name" {
  type    = string
  default = ""
}

variable "prom_stack_prometheus_server_volume_size" {
  type    = string
  default = "20Gi"
}

variable "prom_stack_prometheus_alert_manager_volume_size" {
  type    = string
  default = "5Gi"
}

variable "has_dedicated_infra_nodes" {
  type        = bool
  default     = false
  description = "If enabled, components will be deployed on dedicated nodes with label role:infra"
}

variable "prom_stack_github_oauth_organization" {
  type        = string
  default     = ""
  description = "Allowed organization for Github OAuth"
}

variable "prom_stack_github_oauth_domains" {
  type        = string
  default     = ""
  description = "Allowed domains for Github OAuth"
}

variable "prom_stack_grafana_admins_team" {
  type        = string
  description = "Name of Grafana admins-team on GitHub"
  default     = "grafana-admins"
}

variable "prom_stack_awssm_sso_secret_name" {
  type        = string
  description = "Name of AWSSM secret where sso secrets are stored"
  default     = "grafana-sso"
}

variable "prom_stack_grafana_sso_enabled" {
  type        = bool
  default     = false
  description = "Enable or not Github OAuth"
}

variable "cluster_secret_store_ref_name" {
  type        = string
  description = "ClusterSecretStore name"
  default     = "global-cluster-secretstore"
}
