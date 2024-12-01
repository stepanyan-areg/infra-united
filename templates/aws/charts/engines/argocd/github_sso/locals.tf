locals {
  cluster_secret_store_yaml_path = "${path.module}/yamls/cluster-secret-store.yaml"
  github_sso_secret_yaml_path    = "${path.module}/yamls/github-sso-secret.yaml"

  cluster_secret_store_yaml = templatefile(local.cluster_secret_store_yaml_path, {
    region                          = var.region
    external_secrets_namespace      = var.external_secrets_namespace
    external_secrets_serviceaccount = var.external_secrets_serviceaccount
    namespace                       = var.namespace
  })

  github_sso_secret_argocd_yaml = templatefile(local.github_sso_secret_yaml_path, {
    awssm_secret_name        = var.awssm_secret_name
    argocd_github_sso_secret = var.argocd_github_sso_secret
    namespace                = var.namespace
    secret_store_ref_name    = kubectl_manifest.cluster-secret-store.name
    secret_store_ref_kind    = kubectl_manifest.cluster-secret-store.kind
  })
}