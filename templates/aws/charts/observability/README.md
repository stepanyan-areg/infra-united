<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_loki_stack"></a> [loki\_stack](#module\_loki\_stack) | ./loki_stack | n/a |
| <a name="module_prom_stack"></a> [prom\_stack](#module\_prom\_stack) | ./prom_stack | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | # Common variables | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | n/a | yes |
| <a name="input_has_dedicated_infra_nodes"></a> [has\_dedicated\_infra\_nodes](#input\_has\_dedicated\_infra\_nodes) | If enabled, components will be deployed on dedicated nodes with label role:infra | `bool` | `false` | no |
| <a name="input_loki_stack_enabled"></a> [loki\_stack\_enabled](#input\_loki\_stack\_enabled) | loki\_stack | `bool` | `true` | no |
| <a name="input_loki_stack_loki_volume_size"></a> [loki\_stack\_loki\_volume\_size](#input\_loki\_stack\_loki\_volume\_size) | n/a | `string` | `"20Gi"` | no |
| <a name="input_loki_stack_namespace"></a> [loki\_stack\_namespace](#input\_loki\_stack\_namespace) | n/a | `string` | `"monitoring"` | no |
| <a name="input_loki_stack_service_port"></a> [loki\_stack\_service\_port](#input\_loki\_stack\_service\_port) | n/a | `number` | `3100` | no |
| <a name="input_prom_stack_enabled"></a> [prom\_stack\_enabled](#input\_prom\_stack\_enabled) | prom\_stack | `bool` | `true` | no |
| <a name="input_prom_stack_ingress_enabled"></a> [prom\_stack\_ingress\_enabled](#input\_prom\_stack\_ingress\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_prom_stack_ingress_group_name"></a> [prom\_stack\_ingress\_group\_name](#input\_prom\_stack\_ingress\_group\_name) | n/a | `string` | `""` | no |
| <a name="input_prom_stack_namespace"></a> [prom\_stack\_namespace](#input\_prom\_stack\_namespace) | n/a | `string` | `"monitoring"` | no |
| <a name="input_prom_stack_prometheus_alert_manager_volume_size"></a> [prom\_stack\_prometheus\_alert\_manager\_volume\_size](#input\_prom\_stack\_prometheus\_alert\_manager\_volume\_size) | n/a | `string` | `"5Gi"` | no |
| <a name="input_prom_stack_prometheus_server_volume_size"></a> [prom\_stack\_prometheus\_server\_volume\_size](#input\_prom\_stack\_prometheus\_server\_volume\_size) | n/a | `string` | `"20Gi"` | no |
| <a name="input_prom_stack_serviceaccount"></a> [prom\_stack\_serviceaccount](#input\_prom\_stack\_serviceaccount) | n/a | `string` | `"prom-stack"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alertmanager_url"></a> [alertmanager\_url](#output\_alertmanager\_url) | n/a |
| <a name="output_grafana_url"></a> [grafana\_url](#output\_grafana\_url) | n/a |
| <a name="output_prom_url"></a> [prom\_url](#output\_prom\_url) | n/a |
<!-- END_TF_DOCS -->