resource "helm_release" "argocd" {
  namespace        = var.namespace
  name             = var.chart_name
  chart            = var.chart_name
  repository       = var.repository
  create_namespace = var.create_namespace
  version          = var.chart_version
  recreate_pods    = var.recreate_pods
  timeout          = var.timeout
  wait             = true

  values = [
    local.argocd_values
  ]

  set {
    name  = "clusterName"
    value = var.cluster_name
  } 

  dynamic "set" {
    for_each = var.extra_values
    content {
      name  = set.key
      value = set.value
    }
  }

  lifecycle {
    precondition {
      condition     = fileexists(local.values_yaml_path)
      error_message = " --> Error: Failed to find '${local.values_yaml_path}'. Exit terraform process."
    }
  }
}

resource "kubectl_manifest" "main_project" {
  yaml_body = local.app_project_yaml

  depends_on = [
    helm_release.argocd
  ]

  lifecycle {
    precondition {
      condition     = fileexists(local.app_project_yaml_path)
      error_message = " --> Error: Failed to find '${local.app_project_yaml_path}'. Exit terraform process."
    }
  }
}

# Sync ECR registry with ARGOCD
module "ecr_reg" {
  count               = var.ecr_reg_enabled ? 1 : 0
  source              = "./ecr_reg"
  namespace           = var.namespace
  region              = var.region
  serviceaccount      = var.serviceaccount
  eks_oidc_issuer_url = var.eks_oidc_issuer_url
  ecr_role_name       = local.ecr_role_name
  account_id          = data.aws_caller_identity.current.account_id

  depends_on = [
    helm_release.argocd
  ]
}

# Create & Sync GitOps repository with ARGOCD
module "gitops_repo" {
  count                  = var.gitops_repo_enabled && var.github_org_name != "" ? 1 : 0
  source                 = "./gitops_repo"
  create_github_repo     = true
  github_org_name        = var.github_org_name
  github_repo_name       = var.github_repo_name
  gitops_apps_dir_path   = var.gitops_apps_dir_path
  namespace              = var.namespace
  app_proj_name          = kubectl_manifest.main_project.name

  depends_on = [
    helm_release.argocd
  ]
}

# Sync Microservices repository with ARGOCD
module "github_repositories" {
  for_each               = var.github_connect_repositories_enabled && var.github_org_name != "" ? toset(var.github_repositories_name) : []
  source                 = "./gitops_repo"
  create_github_repo     = false
  github_org_name        = var.github_org_name
  github_repo_name       = each.key
  namespace              = var.namespace

  depends_on = [
    helm_release.argocd
  ]
}


# GitHub SSO for ArgoCD
module "github_sso_argocd" {
  count                           = local.argocd_sso_enabled ? 1 : 0
  source                          = "./github_sso"
  region                          = var.region
  namespace                       = var.namespace
  awssm_secret_name               = var.awssm_secret_name
  argocd_github_sso_secret        = var.argocd_github_sso_secret
  external_secrets_namespace      = var.external_secrets_namespace
  external_secrets_serviceaccount = var.external_secrets_serviceaccount
}

# GitHub SSO for Argo-Workflows in different namespace
module "github_sso_argo_workflows" {
  count                           = local.argo_workflows_sso_enabled && local.separate_namespaces ? 1 : 0
  source                          = "./github_sso"
  region                          = var.region
  namespace                       = var.argo_workflows_namespace
  awssm_secret_name               = var.awssm_secret_name
  argocd_github_sso_secret        = var.argocd_github_sso_secret
  external_secrets_namespace      = var.external_secrets_namespace
  external_secrets_serviceaccount = var.external_secrets_serviceaccount
}

# set {
#     name  = "server.config.statusbadge\\.enabled"
#     value = "true"
#     type  = "string"
#   }

#   #TODO: Enable  metics.

#   ## Notificattions:
#   set {
#     name  = "notifications.argocdUrl"
#     value = "https://${var.argo_cd.host}"
#   }

#   set {
#     name  = "notifications.secret.create"
#     value = "false"
#   }

#   set {
#     name  = "notifications.secret.name"
#     value = "argocd-notifications-secret"
#   }

#   set {
#     name  = "notifications.cm.create"
#     value = "false"
#   }

#   set {
#     name  = "notifications.cm.name"
#     value = "argocd-notifications-cm"
#   }

#   # Disable applicationsets:
#   # https://github.com/argoproj/argo-helm/issues/1180
#   set {
#     name  = "applicationSet.enabled"
#     value = "false"
#   }

#   depends_on = [
#     kubectl_manifest.argocd_notifications_secret,
#     kubectl_manifest.argocd_notifications_cm,
#     time_sleep.wait # wait until ingress is ready
#   ]

# }

# resource "kubectl_manifest" "argocd_notifications_secret" {
#   count              = var.argo_cd.enabled ? 1 : 0
#   override_namespace = var.argo_cd.namespace
#   yaml_body = templatefile("${path.module}/templates/argocd-notifications-secret.yaml.tpl", {
#     slack_token = var.slack_token
#   })

# }

# # notifications https://github.com/argoproj/argo-cd/blob/master/notifications_catalog/install.yaml
# resource "kubectl_manifest" "argocd_notifications_cm" {
#   count              = var.argo_cd.enabled ? 1 : 0
#   override_namespace = var.argo_cd.namespace
#   yaml_body = templatefile("${path.module}/templates/argocd-notifications-cm.yaml.tpl", {
#     host        = var.argo_cd.host,
#     environment = var.environment
#   })
#   depends_on = [
#     kubectl_manifest.argocd_notifications_secret,
#   ]
# }
