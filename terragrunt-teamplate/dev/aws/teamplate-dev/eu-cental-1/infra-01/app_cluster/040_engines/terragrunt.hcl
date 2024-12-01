terraform {
  source = "${get_repo_root()}/templates/aws/charts/engines"
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

dependency "zone_apprandom" {
  config_path = "../../../../../../../shared-resources-767397678436/aws/shared-resources/global/route53/dev.apprandom.com/"
}

dependency "acm_apprandom" {
  config_path = "../../acm/dev.apprandom.com"
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
  mock_outputs = {
    external_secrets_namespace      = "external-secrets"
    external_secrets_serviceaccount = "external-secrets"
  }
}

locals {
  my_region       = include.root.locals.my_region_conf.locals.my_region
  github_org_name = include.root.locals.my_org_conf.locals.github_org_name
  argocd_scanners_repos = include.root.locals.my_org_conf.locals.argocd_scanners_repos
}

inputs = {
  region                                   = local.my_region
  cluster_name                             = dependency.eks.outputs.eks_cluster_name
  vpc_id                                   = dependency.eks.outputs.vpc_id
  domain_name                              = dependency.zone_apprandom.outputs.route53_zone_name["dev.apprandom.com"]
  acm_certificate_arn                      = dependency.acm_apprandom.outputs.acm_certificate_arn
  cluster_oidc_provider                    = dependency.eks.outputs.eks_oidc_provider

  has_dedicated_infra_nodes                = dependency.eks.outputs.has_dedicated_infra_nodes

  # argocd
  argocd_enabled                           = true
  argocd_namespace                         = "argocd"
  eks_oidc_issuer_url                      = dependency.eks.outputs.eks_oidc_issuer_url

  argocd_ingress_group_name                = "system-internal"

      # GitHub SSO
  argocd_sso_enabled                       = true
  argocd_sso_org                           = local.github_org_name
  argocd_github_admins_team                = "argocd-admins"
  awssm_secret_name                        = "argocd-sso" # AWS Secrets Manager Where 'clientId' & 'clientSecret' of GitHub application are stored.
  external_secrets_namespace               = dependency.system_charts.outputs.external_secrets_namespace
  external_secrets_serviceaccount          = dependency.system_charts.outputs.external_secrets_serviceaccount

      # Connect ECR registry
  ecr_reg_enabled                          = false

  # --> Connect Github repositories
  github_org_name                          = local.github_org_name
    # Create & Connect GitOps repository With application.yaml which points to 'gitops_apps_dir_path'.
  gitops_repo_enabled                      = false
  github_repo_name                         = "gitops"
  gitops_apps_dir_path                     = "applications" # The directory where all 'application.yaml' will be stored.
    # Connect microservices repositories
  github_connect_repositories_enabled      = true
  github_repositories_name                 = local.argocd_scanners_repos
}
