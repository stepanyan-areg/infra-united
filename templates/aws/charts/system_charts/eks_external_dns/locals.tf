locals {
  base_values = templatefile("${path.module}/values.yaml", {
    region                    = var.region
    cluster_name              = var.cluster_name
    sa_name                   = var.serviceaccount
    irsa_role                 = var.override_irsa_role != "" ? var.override_irsa_role : module.external_dns_irsa_role.iam_role_arn
    release_name              = var.name
    domain                    = var.domain_name
    has_dedicated_infra_nodes = var.has_dedicated_infra_nodes
  })
}
