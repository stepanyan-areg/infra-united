module "argocd" {
  count                               = var.argocd_enabled ? 1 : 0
  source                              = "./argocd"
  region                              = var.region
  release_name                        = var.argocd_release_name
  cluster_name                        = var.cluster_name
  namespace                           = var.argocd_namespace
  hostname                            = local.argocd_hostname
  eks_oidc_issuer_url                 = var.eks_oidc_issuer_url
  github_org_name                     = var.github_org_name
  github_connect_repositories_enabled = var.github_connect_repositories_enabled
  github_repositories_name            = var.github_repositories_name
  gitops_repo_enabled                 = var.gitops_repo_enabled
  github_repo_name                    = var.github_repo_name
  gitops_apps_dir_path                = var.gitops_apps_dir_path
  argocd_github_sso_secret            = var.argocd_github_sso_secret
  ecr_reg_enabled                     = var.ecr_reg_enabled
  sso_enabled                         = var.argocd_sso_enabled
  sso_org                             = var.argocd_sso_org
  github_admins_team                  = var.argocd_github_admins_team
  awssm_secret_name                   = var.awssm_secret_name
  external_secrets_namespace          = var.external_secrets_namespace
  external_secrets_serviceaccount     = var.external_secrets_serviceaccount
  argo_workflows_sso_enabled          = var.argo_workflows_enabled && var.argo_workflows_sso_enabled
  argo_workflows_hostname             = local.argo_workflows_hostname
  argo_workflows_namespace            = var.argo_workflows_namespace
  argo_rollouts_extension_enable      = var.argo_rollouts_extension_enable
  has_dedicated_infra_nodes           = var.has_dedicated_infra_nodes
  ingress_group_name                  = var.argocd_ingress_group_name
}

# module "github_runners" {
#   source                        = "./github_runners"
#   enabled                       = var.github_actions_runner_controller_enabled
#   environment                   = var.environment
#   cluster_oidc_provider         = var.cluster_oidc_provider
#   serviceaccount                = var.github_runner_serviceaccount
#   github_token                  = var.github_token
#   token_ssm_parameter           = var.github_token_ssm_parameter
#   runnerGithubURL               = var.github_runner_reg_url
#   webhook_server_enabled        = var.github_webhook_server_enabled
#   webhook_server_host           = var.github_webhook_server_host
#   webhook_server_path           = var.github_webhook_server_path
#   webhook_server_secret_enabled = var.github_webhook_server_secret_enabled
#   depends_on                    = [module.cluster-autoscaler, module.alb-controller]
#   runners_deploy_list           = var.github_runners_deploy_list
# }
