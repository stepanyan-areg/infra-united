# resource "kubernetes_namespace" "namespace" {
#   metadata {
#     name = var.namespace
#   }
# }

resource "kubectl_manifest" "cluster-secret-store" {
  yaml_body = local.cluster_secret_store_yaml

  lifecycle {
    precondition {
      condition     = fileexists(local.cluster_secret_store_yaml_path)
      error_message = " --> Error: Failed to find '${local.cluster_secret_store_yaml_path}'. Exit terraform process."
    }
  }
}

resource "kubectl_manifest" "github-app-secrets-argocd" {
  yaml_body = local.github_sso_secret_argocd_yaml

  lifecycle {
    precondition {
      condition     = fileexists(local.github_sso_secret_yaml_path)
      error_message = " --> Error: Failed to find '${local.github_sso_secret_yaml_path}'. Exit terraform process."
    }
  }
}