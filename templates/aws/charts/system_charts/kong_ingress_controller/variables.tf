variable "namespace" {
  description = "The namespace to install the chart"
  type        = string
  default     = "kong"
}

variable "name" {
  description = "The name of the chart"
  type        = string
  default     = "kong"
}

variable "kong_chart_version" {
  description = "The version of the chart"
  type        = string
  default     = "2.26.3"
}

variable "extra_values" {
  description = "Extra values to pass to the chart"
  type        = map(string)
  default     = {}
}

variable "has_dedicated_infra_nodes" {
  type        = bool
  default     = false
  description = "If enabled, components will be deployed on dedicated nodes with label role:infra"
}
