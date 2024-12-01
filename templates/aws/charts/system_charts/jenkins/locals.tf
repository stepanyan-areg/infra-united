locals {
  base_values = yamldecode(
    templatefile("${path.module}/values.yaml", {
      release_name               = var.name
      namespace                  = var.namespace
      jenkins_domain_name        = var.jenkins_domain_name
      jenkins_tls_cluster_issuer = var.jenkins_tls_cluster_issuer
      jenkins_admin_user         = var.jenkins_admin_user
      jenkins_admin_password     = var.jenkins_admin_password
      storage_class              = var.jenkins_storage_class
      storage_size               = var.jenkins_storage_size
      has_dedicated_infra_nodes  = var.has_dedicated_infra_nodes
    })
  )
}
