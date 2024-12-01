output "grafana_url" {
  value = var.prom_stack_enabled ? module.prom_stack.grafana_url : null
}

output "prom_url" {
  value = var.prom_stack_enabled ? module.prom_stack.prom_url : null
}

output "alertmanager_url" {
  value = var.prom_stack_enabled ? module.prom_stack.alertmanager_url : null
}