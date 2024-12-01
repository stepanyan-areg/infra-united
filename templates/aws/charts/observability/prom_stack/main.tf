resource "helm_release" "prom_stack" {
  count            = var.enabled ? 1 : 0
  name             = var.name
  chart            = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  create_namespace = var.namespace == "kube-system" ? false : true
  version          = var.chart_version
  namespace        = var.namespace
  values           = [local.base_values]


  # Set additional values based on variables
  set {
    name  = "serviceAccount.name"
    value = var.serviceaccount
  }

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
}

# GitHub SSO for Grafana
module "github_sso_grafana" {
  count                         = var.grafana_sso_enabled ? 1 : 0
  source                        = "./github_sso"
  namespace                     = var.namespace
  awssm_secret_name             = var.awssm_sso_secret_name
  grafana_github_sso_secret     = var.grafana_github_sso_secret
  cluster_secret_store_ref_name = var.cluster_secret_store_ref_name
}
