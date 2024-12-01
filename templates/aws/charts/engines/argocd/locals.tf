locals {

  ecr_role_name = "ecr-role-${var.cluster_name}"
  ecr_role_arn  = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${local.ecr_role_name}"

  argocd_sso_enabled         = var.sso_enabled && var.github_admins_team != "" && var.awssm_secret_name != ""
  argo_workflows_sso_enabled = local.argocd_sso_enabled && var.argo_workflows_sso_enabled
  separate_namespaces        = var.namespace != var.argo_workflows_namespace

  values_yaml_path      = "${path.module}/yamls/values.yaml"
  app_project_yaml_path = "${path.module}/yamls/app-project.yaml"

  repositories_url = concat(
    var.ecr_reg_enabled ? [module.ecr_reg[0].ecr_url] : [],
    var.gitops_repo_enabled ? [module.gitops_repo[0].ssh_clone_url] : [],
    (!var.ecr_reg_enabled && !var.gitops_repo_enabled) ? ["*"] : []
  )

  argocd_values = templatefile(local.values_yaml_path, {
    sa_name                        = var.serviceaccount
    release_name                   = var.release_name
    hostname                       = var.hostname
    ecr_reg_enabled                = var.ecr_reg_enabled
    ecr_role_arn                   = local.ecr_role_arn
    sso_enabled                    = local.argocd_sso_enabled
    sso_org                        = var.sso_org
    github_admins_team             = var.github_admins_team
    argocd_github_sso_secret       = var.argocd_github_sso_secret
    argo_workflows_sso_enabled     = var.argo_workflows_sso_enabled
    argo_workflows_hostname        = var.argo_workflows_hostname
    argo_rollouts_extension_enable = var.argo_rollouts_extension_enable
    extension_url                  = var.extension_url
    has_dedicated_infra_nodes      = var.has_dedicated_infra_nodes
    ingress_group_name             = var.ingress_group_name
  })

  app_project_yaml = templatefile(local.app_project_yaml_path, {
    namespace        = var.namespace
    repositories_url = local.repositories_url
  })
}
