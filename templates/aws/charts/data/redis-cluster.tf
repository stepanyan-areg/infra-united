resource "helm_release" "redis_cluster" {
  count      = var.redis_cluster_enabled ? 1 : 0
  name       = var.redis_cluster_release_name
  namespace  = var.redis_cluster_namespace
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis-cluster"
  version    = var.redis_cluster_chart_version
  create_namespace = true

  values = [
    file("${path.module}/values/redis-cluster-values.yaml"),
    var.redis_cluster_values_override
  ]
}
