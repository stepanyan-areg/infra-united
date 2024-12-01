resource "helm_release" "loki" {
  count            = var.enabled ? 1 : 0
  name             = "loki"
  chart            = "loki"
  repository       = "https://grafana.github.io/helm-charts"
  create_namespace = var.namespace == "kube-system" ? false : true
  version          = var.loki_chart_version
  namespace        = var.namespace
  values           = [local.base_loki_values]

  dynamic "set" {
    for_each = var.loki_extra_values
    content {
      name  = set.key
      value = set.value
    }
  }
}

resource "helm_release" "promtail" {
  count            = var.enabled ? 1 : 0
  name             = "promtail"
  chart            = "promtail"
  repository       = "https://grafana.github.io/helm-charts"
  create_namespace = var.namespace == "kube-system" ? false : true
  version          = var.promtail_chart_version
  namespace        = var.namespace
  values           = [local.base_promtail_values]

  # Set additional values based on variables
  dynamic "set" {
    for_each = var.promtail_extra_values
    content {
      name  = set.key
      value = set.value
    }
  }
}
