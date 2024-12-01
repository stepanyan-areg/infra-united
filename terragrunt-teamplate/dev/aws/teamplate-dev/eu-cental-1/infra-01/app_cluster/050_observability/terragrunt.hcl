terraform {
  source = "${get_repo_root()}/templates/aws/charts/observability"
}

# For Inputs
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

# For AWS provider & tfstate S3 backand
include "cloud" {
  path = find_in_parent_folders("cloud.hcl")
}

# For Helm, Kubectl & GitHub providers
include "common_providers" {
  path = find_in_parent_folders("providers.hcl")
}

dependency "eks" {
  config_path  = "../010_eks"
  mock_outputs = {
    vpc_id                    = "vpc-1234"
    eks_endpoint              = "https://example.com/eks"
    eks_cluster_name          = "test_cluster"
    eks_oidc_provider         = "arn::test"
    eks_oidc_issuer_url       = "https://"
    has_dedicated_infra_nodes = false
  }
  mock_outputs_merge_strategy_with_state = "deep_map_only"
  mock_outputs_allowed_terraform_commands = ["init", "validate"]
}

dependency "system_charts"{
  config_path = "../020_system_charts"
  skip_outputs = true
}

dependency "zone_apprandom" {
  config_path = "../../../../../../../shared-resources-767397678436/aws/shared-resources/global/route53/dev.apprandom.com/"
}

dependency "acm_apprandom" {
  config_path = "../../acm/dev.apprandom.com"
}

locals {
  github_org_name     = include.root.locals.my_org_conf.locals.github_org_name
  github_team         = include.root.locals.my_org_conf.locals.github_grafana_admins_team
  github_domains      = include.root.locals.my_org_conf.locals.github_oauth_domains
}

inputs = {
  cluster_region                                  = dependency.eks.outputs.eks_region
  cluster_name                                    = dependency.eks.outputs.eks_cluster_name
  vpc_id                                          = dependency.eks.outputs.vpc_id
  domain_name                                     = dependency.zone_apprandom.outputs.route53_zone_name["dev.apprandom.com"]
  acm_certificate_arn                             = dependency.acm_apprandom.outputs.acm_certificate_arn
  cluster_oidc_provider                           = dependency.eks.outputs.eks_oidc_provider

  has_dedicated_infra_nodes                       = dependency.eks.outputs.has_dedicated_infra_nodes
  cluster_secret_store_ref_name                   = "global-cluster-secretstore"

  # prom stack
  prom_stack_enabled                              = true
  prom_stack_grafana_sso_enabled                  = true # GitHub provider
  prom_stack_github_oauth_organization            = local.github_org_name
  prom_stack_grafana_admins_team                  = local.github_team
  prom_stack_github_oauth_domains                 = local.github_domains
  prom_stack_awssm_sso_secret_name                = "grafana-sso" # Secret name within AWS Secrets Manager Where 'clientId' & 'clientSecret' of GitHub application are stored.
  prom_stack_namespace                            = "monitoring"
  prom_stack_serviceaccount                       = "prom-stack"
  prom_stack_ingress_enabled                      = true
  prom_stack_ingress_group_name                   = "system-internal"
  prom_stack_prometheus_server_volume_size        = "100Gi"
  prom_stack_prometheus_alert_manager_volume_size = "10Gi"

  # Loki stack
  loki_stack_enabled                              = true
  loki_stack_namespace                            = "monitoring"
  loki_stack_loki_volume_size                     = "200Gi"
}
