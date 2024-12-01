variable "name" {
  description = "Release name for Jenkins"
  type        = string
}

variable "namespace" {
  description = "Namespace to deploy Jenkins"
  type        = string
}

variable "chart_version" {
  description = "Version of the Jenkins Helm chart to deploy"
  type        = string
}

variable "jenkins_domain_name" {
  description = "Domain name for Jenkins ingress"
  type        = string
}

variable "jenkins_tls_cluster_issuer" {
  description = "Cluster issuer for cert-manager"
  type        = string
  default     = "letsencrypt-prod"
}

variable "jenkins_admin_user" {
  description = "Jenkins admin username"
  type        = string
  default     = "admin"
}

variable "jenkins_admin_password" {
  description = "Jenkins admin password"
  type        = string
}

variable "jenkins_storage_class" {
  description = "Storage class for Jenkins persistence"
  type        = string
  default     = "gp2"
}

variable "jenkins_storage_size" {
  description = "Storage size for Jenkins persistence"
  type        = string
  default     = "10Gi"
}

variable "has_dedicated_infra_nodes" {
  description = "Flag to determine if dedicated infra nodes are used"
  type        = bool
  default     = false
}
