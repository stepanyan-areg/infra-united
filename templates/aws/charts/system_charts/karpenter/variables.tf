variable "name" {
  type        = string
  description = "Name of release"
  default     = "karpenter"
}

variable "namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "karpenter"
}

variable "chart_version" {
  type        = string
  description = "Helm chart to release"
  default     = "v0.34.0"
}

variable "create_role_enabled" {
  type        = bool
  description = "Enable or not chart as a component"
  default     = false
}

variable "serviceaccount" {
  type        = string
  description = "Serviceaccount name"
  default     = "karpenter"
}
variable "wait" {
  type        = bool
  description = "Wait for successfull helm release"
  default     = false
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

variable "cluster_endpoint" {
  type        = string
  description = "EKS cluster OIDC provider ARN"
}

variable "has_dedicated_infra_nodes" {
  type        = bool
  default     = false
  description = "If enabled, components will be deployed on dedicated nodes with label role:infra"
}
