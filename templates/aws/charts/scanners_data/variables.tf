## Common variables
variable "region" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "cluster_oidc_provider" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "domain_name" {
  type = string
}
variable "acm_certificate_arn" {
  type = string
}

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

variable "redis_cluster_enabled" {
  description = "Whether to deploy the Redis Cluster chart"
  type        = bool
  default     = false
}

variable "redis_cluster_release_name" {
  description = "Name of the Redis Cluster Helm release"
  type        = string
  default     = "redis-cluster"
}

variable "redis_cluster_namespace" {
  description = "Kubernetes namespace for Redis Cluster"
  type        = string
  default     = "redis-cluster"
}

variable "redis_cluster_chart_version" {
  description = "Version of the Redis Cluster Helm chart"
  type        = string
  default     = "10.2.7"
}

variable "redis_cluster_values_override" {
  description = "YAML string to override Redis Cluster Helm values"
  type        = string
  default     = ""
}

variable "mongodb_cluster_enabled" {
  description = "Whether to deploy the MongoDB Cluster chart"
  type        = bool
  default     = true
}

variable "mongodb_cluster_release_name" {
  description = "Name of the MongoDB Cluster Helm release"
  type        = string
  default     = "mongodb-cluster"
}

variable "mongodb_cluster_namespace" {
  description = "Kubernetes namespace for MongoDB Cluster"
  type        = string
  default     = "mongodb-cluster"
}

variable "mongodb_cluster_chart_version" {
  description = "Version of the MongoDB Cluster Helm chart"
  type        = string
  default     = "15.6.14"
}

variable "mongodb_cluster_values_override" {
  description = "YAML string to override MongoDB Cluster Helm values"
  type        = string
  default     = ""
}