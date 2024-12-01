## Common
variable "cluster_oidc_provider" {
  description = "The OIDC provider to use for the cluster"
  type        = string
  default     = "oidc.eks.region.amazonaws.com/id/cluster_name:sub"
}

variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
}

variable "region" {
  description = "The region to host the cluster in"
  type        = string
}

# variable "vpc_id" {
#   description = "The VPC ID to host the cluster in"
#   type        = string
# }

variable "cluster_endpoint" {
  type        = string
  description = "EKS cluster endpoint"
}

## Cluster autoscaler
variable "cluster_autoscaler_enabled" {
  type    = bool
  default = false
}

variable "cluster_autoscaler_namespace" {
  type    = string
  default = "kube-system"
}

variable "cluster_autoscaler_serviceaccount" {
  type    = string
  default = "cluster-autoscaler"
}

variable "cluster_autoscaler_extra_values" {
  type    = map(any)
  default = {}
}

## Karpenter
variable "karpenter_enabled" {
  type        = bool
  default     = false
  description = "Whether to install karpenter"
}

variable "karpenter_namespace" {
  type    = string
  default = "kube-system"
}

## AWS LB Controller
variable "alb_controller_enabled" {
  type    = bool
  default = false
}
variable "alb_controller_namespace" {
  type    = string
  default = "kube-system"
}
variable "alb_controller_serviceaccount" {
  type    = string
  default = "alb-controller"
}

## Kong
variable "kong_enabled" {
  description = "Whether to install kong"
  type        = bool
  default     = false
}

variable "kong_namespace" {
  description = "The namespace to install kong"
  type        = string
  default     = "kong"
}

variable "kong_version" {
  description = "The version to install kong"
  type        = string
  default     = "2.26.3"
}

variable "kong_extra_values" {
  description = "Extra values to pass to the chart"
  type        = map(string)
  default     = {}
}

## External DNS
variable "eks_external_dns_enabled" {
  description = "Whether to install external-dns for eks"
  type        = bool
  default     = false
}

variable "external_dns_namespace" {
  description = "The namespace to install external-dns"
  type        = string
  default     = "external-dns"
}

variable "external_dns_chart_name" {
  description = "The chart name to install external-dns"
  type        = string
  default     = "external-dns"
}
variable "external_dns_chart_version" {
  description = "The chart version to install external-dns"
  type        = string
  default     = "1.12.0"
}

variable "external_dns_service_account_name" {
  description = "The service account name to install external-dns"
  type        = string
  default     = "external-dns"
}

variable "external_dns_domain_filter" {
  description = "The domain filter to install external-dns"
  type        = string
  default     = "Just a place holder to make this param Optional"
}

variable "external_dns_extra_values" {
  description = "Extra values to pass to the chart"
  type        = map(string)
  default     = {}
}
variable "override_irsa_role" {
  type        = string
  description = "Override the default IRSA role for external DNS"
  default     = ""
}

## External Secrets
variable "external_secrets_enabled" {
  type    = bool
  default = false
}

variable "external_secrets_namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "kube-system"
}

variable "external_secrets_serviceaccount" {
  type        = string
  description = "Serviceaccount name"
  default     = "external-secrets"
}

variable "external_secrets_ssm_parameter_arns" {
  type        = list(string)
  description = "SSM parameter ARNS"
  default     = ["arn:aws:ssm:*:*:parameter/*"]
}

variable "external_secrets_secrets_manager_arns" {
  type        = list(string)
  description = "secrets manager ARNS"
  default     = ["arn:aws:secretsmanager:*:*:secret:*"]
}

## EBS CSI Driver
variable "ebs_csi_enabled" {
  type    = bool
  default = false
}

variable "ebs_csi_driver_namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "kube-system"
}

variable "ebs_csi_driver_serviceaccount" {
  type        = string
  description = "Serviceaccount name"
  default     = "ebs-csi"
}

# Metrics Server
variable "metrics_server_enabled" {
  type    = bool
  default = false
}

variable "metrics_server_namespace" {
  type        = string
  description = "Namespace name to deploy helm release"
  default     = "kube-system"
}

variable "metrics_server_serviceaccount" {
  type        = string
  description = "Serviceaccount name"
  default     = "metrics-server"
}

# AWS node termination handler
variable "aws_node_termination_handler_enabled" {
  type    = bool
  default = false
}

variable "aws_node_termination_handler_namespace" {
  type    = string
  default = "kube-system"
}

variable "aws_node_termination_handler_serviceaccount" {
  type    = string
  default = "aws-node-termination-handler"
}

# keda
variable "keda_enabled" {
  type    = bool
  default = false
}

variable "keda_namespace" {
  type    = string
  default = "keda"
}

# reloader
variable "reloader_enabled" {
  type    = bool
  default = false
}

variable "reloader_namespace" {
  type    = string
  default = "reloader"
}

variable "has_dedicated_infra_nodes" {
  type        = bool
  default     = false
  description = "If enabled, components will be deployed on dedicated nodes with label role:infra"
}

## Nginx ingress controller
variable "ingress_nginx_enabled" {
  description = "Whether to install Nginx Ingress Controller"
  type        = bool
  default     = false
}
variable "ingress_nginx_chart_version" {
  description = "The version of nginx_ingress_controller"
  type        = string
  default     = "4.11.2"
}
variable "ingress_nginx_namespace" {
  type    = string
  default = "ingress-nginx"
}
//Cert Manager
variable "cert_manager_enabled" {
  description = "Whether to install cert-manager"
  type        = bool
  default     = false
}

variable "cert_manager_namespace" {
  description = "The namespace to install cert-manager"
  type        = string
  default     = "cert-manager"
}

variable "cert_manager_helm_chart_version" {
  description = "The chart version to install cert-manager"
  type        = string
  default     = "v1.11.0"
}

variable "cert_manager_issuer_email" {
  description = "The email to use for the cert-manager issuer"
  type        = string
  default     = ""
}

//Jenkins
variable "ingress_email_issuer" {
  default     = "no-reply@example.cloud"
  description = "You must replace this email address with your own. The certificate provider will use this to contact you about expiring certificates, and issues related to your account."
}

variable "jenkins_enabled" {
  description = "Enable or disable Jenkins deployment"
  type        = bool
  default     = true
}

variable "jenkins_release_name" {
  description = "Release name for Jenkins"
  type        = string
  default     = "jenkins"
}

variable "jenkins_namespace" {
  description = "Namespace for Jenkins"
  type        = string
  default     = "jenkins"
}

variable "jenkins_chart_version" {
  description = "Version of the Jenkins Helm chart"
  type        = string
  default     = "4.1.3" # Replace with the desired version
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

variable "ingress_nginx_release_name" {
  description = "Release name for NGINX Ingress Controller"
  type        = string
  default     = "ingress-nginx"
}

variable "ingress_nginx_chart_repository" {
  description = "Helm chart repository for NGINX Ingress Controller"
  type        = string
  default     = "https://kubernetes.github.io/ingress-nginx"
}

variable "ingress_nginx_toleration_value" {
  description = "Value for the toleration key in the tolerations"
  type        = string
  default     = "infra"
}

variable "ingress_nginx_node_selector_key" {
  description = "Key for the node selector"
  type        = string
  default     = "karpenter.sh/nodepool"
}

variable "ingress_nginx_node_selector_value" {
  description = "Value for the node selector"
  type        = string
  default     = "infra"
}

variable "ingress_nginx_extra_values" {
  description = "Additional values to merge with base values for NGINX Ingress Controller"
  type        = any
  default     = {}
}
