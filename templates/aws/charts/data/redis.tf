resource "helm_release" "redis" {
  count      = var.redis_enabled ? 1 : 0
  name       = var.redis_release_name
  namespace  = var.redis_namespace
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = var.redis_chart_version
  create_namespace = true

  values = [
    file("${path.module}/values/redis-values.yaml"),
    var.redis_values_override
  ]
}
