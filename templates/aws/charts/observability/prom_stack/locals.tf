locals {
  base_values = templatefile("${path.module}/values.yaml", {
    prometheus_server_volume_size        = var.prometheus_server_volume_size
    prometheus_alert_manager_volume_size = var.prometheus_alert_manager_volume_size
    grafana_admins_team                  = var.grafana_admins_team
    grafana_github_sso_secret            = var.grafana_github_sso_secret
    grafana_sso_enabled                  = var.grafana_sso_enabled
    github_oauth_organization            = var.github_oauth_organization
    github_oauth_domains                 = var.github_oauth_domains
    release_name                         = var.name
    domain                               = var.domain_name
    ingress_enabled                      = var.ingress_enabled
    ingress_group_name                   = var.ingress_group_name
    loki_stack_datasource_enabled        = var.loki_stack_datasource_enabled
    loki_stack_service_port              = var.loki_stack_service_port
    has_dedicated_infra_nodes            = var.has_dedicated_infra_nodes
  })
}
