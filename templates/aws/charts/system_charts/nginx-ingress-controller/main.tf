resource "helm_release" "ingress_nginx" {
  name             = var.name
  repository       = var.chart_repository
  chart            = "ingress-nginx"
  version          = var.chart_version
  create_namespace = var.namespace == "kube-system" ? false : true
  namespace        = var.namespace
  wait             = true
  values           = [yamlencode(local.merged_values)]
}
