# Ingress/LoadBalancer variables
variable "ingress_nginx_enabled" {
  default     = false
  description = "Enable Ingress Nginx for Kubernetes Services (This option provision a Load Balancer)"
}
variable "ingress_load_balancer_shape" {
  default     = "flexible" # Flexible, 10Mbps, 100Mbps, 400Mbps or 8000Mps
  description = "Shape that will be included on the Ingress annotation for the OCI Load Balancer creation"
}
variable "ingress_load_balancer_shape_flex_min" {
  default     = "10"
  description = "Enter the minimum size of the flexible shape."
}
variable "ingress_load_balancer_shape_flex_max" {
  default     = "100"
  description = "Enter the maximum size of the flexible shape (Should be bigger than minimum size). The maximum service limit is set by your tenancy limits."
}

## Resource Ingress examples
variable "ingress_hosts" {
  default     = ""
  description = "Enter a valid full qualified domain name (FQDN). You will need to map the domain name to the EXTERNAL-IP address on your DNS provider (DNS Registry type - A). If you have multiple domain names, include separated by comma. e.g.: mushop.example.com,catshop.com"
}
variable "ingress_hosts_include_nip_io" {
  default     = true
  description = "Include app_name.HEXXX.nip.io on the ingress hosts. e.g.: mushop.HEXXX.nip.io"
}
variable "nip_io_domain" {
  default     = "nip.io"
  description = "Dynamic wildcard DNS for the application hostname. Should support hex notation. e.g.: nip.io"
}
variable "ingress_tls" {
  default     = false
  description = "If enabled, will generate SSL certificates to enable HTTPS for the ingress using the Certificate Issuer"
}
variable "ingress_cluster_issuer" {
  default     = "letsencrypt-prod"
  description = "Certificate issuer type. Currently supports the free Let's Encrypt and Self-Signed. Only *letsencrypt-prod* generates valid certificates"
}

variable "chart_version" {
  description = "The version of nginx_ingress_controller"
  type        = string
  default     = "4.11.2"
}

variable "name" {
  description = "Release name for NGINX Ingress Controller"
  type        = string
  default     = "ingress-nginx"
}

variable "namespace" {
  description = "Namespace to deploy NGINX Ingress Controller"
  type        = string
  default     = "ingress-nginx"
}


variable "chart_repository" {
  description = "Helm chart repository for NGINX Ingress Controller"
  type        = string
  default     = "https://kubernetes.github.io/ingress-nginx"
}

variable "toleration_value" {
  description = "Value for the toleration key in the tolerations"
  type        = string
  default     = "infra"
}

variable "node_selector_key" {
  description = "Key for the node selector"
  type        = string
  default     = "karpenter.sh/nodepool"
}

variable "node_selector_value" {
  description = "Value for the node selector"
  type        = string
  default     = "infra"
}

variable "extra_values" {
  description = "Additional values to merge with base values"
  type        = any
  default     = {}
}
