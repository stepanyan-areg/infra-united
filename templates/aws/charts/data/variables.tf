variable "redis_enabled" {
  description = "Whether to deploy the Redis chart"
  type        = bool
  default     = false
}

variable "redis_release_name" {
  description = "Name of the Redis Helm release"
  type        = string
  default     = "redis"
}

variable "redis_namespace" {
  description = "Kubernetes namespace for Redis"
  type        = string
  default     = "redis"
}

variable "redis_chart_version" {
  description = "Version of the Redis Helm chart"
  type        = string
  default     = "19.6.4"
}

variable "redis_values_override" {
  description = "YAML string to override Redis Helm values"
  type        = string
  default     = ""
}
