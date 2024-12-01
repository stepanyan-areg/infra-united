variable "name" {
  type        = string
  description = "Name of release"
  default     = "cluster-autoscaler"
}

variable "namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "kube-system"
}

variable "chart_version" {
  type        = string
  description = "Helm chart to release"
  default     = "9.21.1"
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
  default     = "cluster-autoscaler"
}

variable "region" {
  type        = string
  description = "AWS region where the ASG placed"
}

variable "cluster_name" {
  type        = string
  description = "Name of EKS cluster"
}

variable "cluster_oidc_provider" {
  type        = string
  description = "EKS cluster OIDC provider ARN"
}

variable "has_dedicated_infra_nodes" {
  type        = bool
  default     = false
  description = "If enabled, components will be deployed on dedicated nodes with label role:infra"
}
