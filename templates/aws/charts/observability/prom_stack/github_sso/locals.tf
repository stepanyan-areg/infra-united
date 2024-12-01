locals {
  github_sso_secret_yaml_path    = "${path.module}/yamls/github-sso-secret.yaml"
  github_sso_secret_grafana_yaml = templatefile(local.github_sso_secret_yaml_path, {
    awssm_secret_name            = var.awssm_secret_name
    grafana_github_sso_secret    = var.grafana_github_sso_secret
    namespace                    = var.namespace
    secret_store_ref_name        = var.cluster_secret_store_ref_name
  })
}
