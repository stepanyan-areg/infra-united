module "loki_stack" {
  source                    = "./loki_stack"
  enabled                   = var.loki_stack_enabled
  namespace                 = var.loki_stack_namespace
  cluster_name              = var.cluster_name
  loki_volume_size          = var.loki_stack_loki_volume_size
  loki_service_port         = var.loki_stack_service_port
  has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
}

module "prom_stack" {
  source                               = "./prom_stack"
  enabled                              = var.prom_stack_enabled
  namespace                            = var.prom_stack_namespace
  cluster_name                         = var.cluster_name
  domain_name                          = var.domain_name
  serviceaccount                       = var.prom_stack_serviceaccount
  prometheus_server_volume_size        = var.prom_stack_prometheus_server_volume_size
  prometheus_alert_manager_volume_size = var.prom_stack_prometheus_alert_manager_volume_size
  ingress_enabled                      = var.prom_stack_ingress_enabled
  ingress_group_name                   = var.prom_stack_ingress_group_name
  loki_stack_datasource_enabled        = var.loki_stack_enabled
  loki_stack_service_port              = var.loki_stack_service_port
  has_dedicated_infra_nodes            = var.has_dedicated_infra_nodes
  grafana_admins_team                  = var.prom_stack_grafana_admins_team
  awssm_sso_secret_name                = var.prom_stack_awssm_sso_secret_name
  cluster_secret_store_ref_name        = var.cluster_secret_store_ref_name
  github_oauth_organization            = var.prom_stack_github_oauth_organization
  github_oauth_domains                 = var.prom_stack_github_oauth_domains
  grafana_sso_enabled                  = var.prom_stack_grafana_sso_enabled
  }
