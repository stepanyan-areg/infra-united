locals {
  argocd_hostname = "${var.argocd_release_name}.${var.domain_name}"
  argocd_url      = "https://${local.argocd_hostname}"

  argo_workflows_hostname     = "${var.argo_workflows_release_name}.${var.domain_name}"
  # argo_workflows_url          = "https://${local.argo_workflows_hostname}"

  #argo_rollouts_hostname      = "${var.argo_rollouts_release_name}.${var.domain_name}"
  #argo_rollouts_url           = "https://${local.argo_rollouts_hostname}"
  #
  #argo_rollouts_demo_hostname = "${var.argo_rollouts_release_name}-demo.${var.domain_name}"
  #argo_rollouts_demo_url      = "https://${local.argo_rollouts_demo_hostname}"
}