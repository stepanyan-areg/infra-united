variable "name" {
  type        = string
  description = "Name of release"
  default     = "alb-controller"
}

variable "namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "kube-system"
}

variable "chart_version" {
  type        = string
  description = "Helm chart to release"
  default     = "1.8.1"
}

variable "create_role_enabled" {
  type        = bool
  description = "Enable or not chart as a component"
  default     = false
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

variable "vpc_id" {
  type        = string
  description = "VPC ID where the cluster is deployed"
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
