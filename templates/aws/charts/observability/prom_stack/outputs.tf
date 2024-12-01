output "grafana_url" {
  value = "https://grafana.${var.domain_name}"
}

output "prom_url" {
  value = "https://prometheus.${var.domain_name}"
}

output "alertmanager_url" {
  value = "https://alertmanager.${var.domain_name}"
}