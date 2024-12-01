variable "namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "loki-stack"
}

variable "loki_chart_version" {
  type        = string
  description = "Loki Helm chart to release"
  default     = "2.15.2"
}

variable "loki_extra_values" {
  type        = map(any)
  description = "Loki Extra values in key value format"
  default     = {}
}

variable "loki_volume_size" {
  type        = string
  default     = "20Gi"
  description = "Size of EBS volume for loki"
}

variable "loki_service_port" {
  type        = number
  default     = 3100
  description = "Loki Service port"
}

variable "promtail_chart_version" {
  type        = string
  description = "Promtail Helm chart to release"
  default     = "6.16.6"
}

variable "promtail_extra_values" {
  type        = map(any)
  description = "Promtail Extra values in key value format"
  default     = {}
}

variable "enabled" {
  type        = bool
  description = "Enable or not chart as a component"
  default     = false
}

variable "cluster_name" {
  type        = string
  description = "Name of EKS cluster"
}

variable "has_dedicated_infra_nodes" {
  type        = bool
  default     = false
  description = "If enabled, components will be deployed on dedicated nodes with label role:infra"
}


