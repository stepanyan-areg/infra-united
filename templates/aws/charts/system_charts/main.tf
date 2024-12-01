# SCALERS
module "cluster-autoscaler" {
  count                     = var.cluster_autoscaler_enabled && !var.karpenter_enabled ? 1 : 0
  source                    = "./cluster_autoscaler"
  enabled                   = var.cluster_autoscaler_enabled
  namespace                 = var.cluster_autoscaler_namespace
  serviceaccount            = var.cluster_autoscaler_serviceaccount
  region                    = var.region
  cluster_name              = var.cluster_name
  cluster_oidc_provider     = var.cluster_oidc_provider
  extra_values              = var.cluster_autoscaler_extra_values
  has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
}

module "karpenter" {
  count                     = var.karpenter_enabled && !var.cluster_autoscaler_enabled ? 1 : 0
  source                    = "./karpenter"
  namespace                 = var.karpenter_namespace
  cluster_name              = var.cluster_name
  cluster_oidc_provider     = var.cluster_oidc_provider
  region                    = var.region
  cluster_endpoint          = var.cluster_endpoint
  has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
}

module "keda" {
  count                     = var.keda_enabled ? 1 : 0
  source                    = "./keda_operator"
  keda_namespace            = var.keda_namespace
  has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
}

module "reloader" {
  count                     = var.reloader_enabled ? 1 : 0
  source                    = "./stakater_reloader"
  reloader_namespace        = var.reloader_namespace
  # has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
}



module "kong" {
  count                     = var.kong_enabled && !var.alb_controller_enabled ? 1 : 0
  source                    = "./kong_ingress_controller"
  namespace                 = var.kong_namespace
  kong_chart_version        = var.kong_version
  extra_values              = var.kong_extra_values
  has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
}

module "aws_node_termination_handler" {
  count                     = var.aws_node_termination_handler_enabled ? 1 : 0
  source                    = "./aws_node_termination_handler"
  namespace                 = var.aws_node_termination_handler_namespace
  serviceaccount            = var.aws_node_termination_handler_serviceaccount
  cluster_name              = var.cluster_name
  has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
}

module "metrics_server" {
  count                     = var.metrics_server_enabled ? 1 : 0
  source                    = "./metrics_server"
  namespace                 = var.metrics_server_namespace
  serviceaccount            = var.metrics_server_serviceaccount
  cluster_name              = var.cluster_name
  has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
}

module "ebs_csi_driver" {
  count                     = var.ebs_csi_enabled ? 1 : 0
  source                    = "./ebs_csi"
  namespace                 = var.ebs_csi_driver_namespace
  serviceaccount            = var.ebs_csi_driver_serviceaccount
  region                    = var.region
  cluster_oidc_provider     = var.cluster_oidc_provider
  has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
}

module "eks_external-dns" {
  count                     = var.eks_external_dns_enabled ? 1 : 0
  source                    = "./eks_external_dns"
  cluster_name              = var.cluster_name
  cluster_oidc_provider     = var.cluster_oidc_provider
  domain_name               = var.external_dns_domain_filter
  region                    = var.region
  extra_values              = var.external_dns_extra_values
  namespace                 = var.external_dns_namespace
  create_role_enabled       = true
  serviceaccount            = var.external_dns_service_account_name
  has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
  override_irsa_role        = var.override_irsa_role
}


module "external_secrets" {
  count                     = var.external_secrets_enabled ? 1 : 0
  source                    = "./external_secrets"
  region                    = var.region
  namespace                 = var.external_secrets_namespace
  serviceaccount            = var.external_secrets_serviceaccount
  cluster_oidc_provider     = var.cluster_oidc_provider
  ssm_parameter_arns        = var.external_secrets_ssm_parameter_arns
  secrets_manager_arns      = var.external_secrets_secrets_manager_arns
  has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
}

module "cert-manager" {
  count                            = var.cert_manager_enabled ? 1 : 0
  source                           = "./certificate_manager"
  namespace                        = var.cert_manager_namespace
  chart_version                    = var.cert_manager_helm_chart_version
  ingress_email_issuer             = var.ingress_email_issuer

}
# INGRESS CONTROLLERS
module "ingress-nginx-controller" {
  count               = var.ingress_nginx_enabled ? 1 : 0
  source              = "./nginx-ingress-controller"
  name                = var.ingress_nginx_release_name
  namespace           = var.ingress_nginx_namespace
  chart_version       = var.ingress_nginx_chart_version
  chart_repository    = var.ingress_nginx_chart_repository
  toleration_value    = var.ingress_nginx_toleration_value
  node_selector_key   = var.ingress_nginx_node_selector_key
  node_selector_value = var.ingress_nginx_node_selector_value
  # extra_values        = var.ingress_nginx_extra_values
}
module "jenkins" {
  count                     = var.jenkins_enabled ? 1 : 0
  source                    = "./jenkins"
  name                      = var.jenkins_release_name
  namespace                 = var.jenkins_namespace
  chart_version             = var.jenkins_chart_version
  jenkins_domain_name       = var.jenkins_domain_name
  jenkins_tls_cluster_issuer = var.jenkins_tls_cluster_issuer
  jenkins_admin_user        = var.jenkins_admin_user
  jenkins_admin_password    = var.jenkins_admin_password
  jenkins_storage_class             = var.jenkins_storage_class
  jenkins_storage_size              = var.jenkins_storage_size
  has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
}
