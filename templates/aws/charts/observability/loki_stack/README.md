## Commands
To get the password for Grafana dashboard admin run:
```bash
kubectl get secret --namespace loki-stack loki-stack-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.12.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.12.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.loki](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.promtail](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of EKS cluster | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Enable or not chart as a component | `bool` | `false` | no |
| <a name="input_has_dedicated_infra_nodes"></a> [has\_dedicated\_infra\_nodes](#input\_has\_dedicated\_infra\_nodes) | If enabled, components will be deployed on dedicated nodes with label role:infra | `bool` | `false` | no |
| <a name="input_loki_chart_version"></a> [loki\_chart\_version](#input\_loki\_chart\_version) | Loki Helm chart to release | `string` | `"2.15.2"` | no |
| <a name="input_loki_extra_values"></a> [loki\_extra\_values](#input\_loki\_extra\_values) | Loki Extra values in key value format | `map(any)` | `{}` | no |
| <a name="input_loki_service_port"></a> [loki\_service\_port](#input\_loki\_service\_port) | Loki Service port | `number` | `3100` | no |
| <a name="input_loki_volume_size"></a> [loki\_volume\_size](#input\_loki\_volume\_size) | Size of EBS volume for loki | `string` | `"20Gi"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace name to deploy helm release | `string` | `"loki-stack"` | no |
| <a name="input_promtail_chart_version"></a> [promtail\_chart\_version](#input\_promtail\_chart\_version) | Promtail Helm chart to release | `string` | `"6.16.6"` | no |
| <a name="input_promtail_extra_values"></a> [promtail\_extra\_values](#input\_promtail\_extra\_values) | Promtail Extra values in key value format | `map(any)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->