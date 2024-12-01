## Commands

To get the password for Grafana dashboard admin run:
```bash
kubectl get secret --namespace monitoring kube-prom-stack-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
``

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.prom_stack](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of EKS cluster | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Roure53 hosted zone name | `string` | n/a | yes |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Helm chart to release | `string` | `"61.5.0"` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Enable or not chart as a component | `bool` | `false` | no |
| <a name="input_extra_values"></a> [extra\_values](#input\_extra\_values) | Extra values in key value format | `map(any)` | `{}` | no |
| <a name="input_has_dedicated_infra_nodes"></a> [has\_dedicated\_infra\_nodes](#input\_has\_dedicated\_infra\_nodes) | If enabled, components will be deployed on dedicated nodes with label role:infra | `bool` | `false` | no |
| <a name="input_ingress_enabled"></a> [ingress\_enabled](#input\_ingress\_enabled) | Enable or not ingress | `bool` | `false` | no |
| <a name="input_ingress_group_name"></a> [ingress\_group\_name](#input\_ingress\_group\_name) | Resuse same ALB by specifying the same ALB group name | `string` | `""` | no |
| <a name="input_loki_stack_datasource_enabled"></a> [loki\_stack\_datasource\_enabled](#input\_loki\_stack\_datasource\_enabled) | Enable Loki Grafana Datasource | `bool` | `false` | no |
| <a name="input_loki_stack_service_port"></a> [loki\_stack\_service\_port](#input\_loki\_stack\_service\_port) | Loki Service port | `number` | `3100` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of release | `string` | `"kube-prom-stack"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name to deploy helm release | `string` | `"monitoring"` | no |
| <a name="input_prometheus_alert_manager_volume_size"></a> [prometheus\_alert\_manager\_volume\_size](#input\_prometheus\_alert\_manager\_volume\_size) | Size of EBS volume for prometheus alert manager | `string` | `"5Gi"` | no |
| <a name="input_prometheus_server_volume_size"></a> [prometheus\_server\_volume\_size](#input\_prometheus\_server\_volume\_size) | Size of EBS volume for prometheus server | `string` | `"20Gi"` | no |
| <a name="input_serviceaccount"></a> [serviceaccount](#input\_serviceaccount) | Serviceaccount name | `string` | `"prom-stack"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alertmanager_url"></a> [alertmanager\_url](#output\_alertmanager\_url) | n/a |
| <a name="output_grafana_url"></a> [grafana\_url](#output\_grafana\_url) | n/a |
| <a name="output_prom_url"></a> [prom\_url](#output\_prom\_url) | n/a |
<!-- END_TF_DOCS -->
