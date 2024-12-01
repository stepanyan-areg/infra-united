locals {
  base_loki_values = templatefile("${path.module}/values.loki.yaml", {
    loki_volume_size          = var.loki_volume_size
    loki_service_port         = var.loki_service_port
    has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
  })
  base_promtail_values = templatefile("${path.module}/values.promtail.yaml", {
    loki_service_port = var.loki_service_port
    cluster_name      = var.cluster_name
  })
}
