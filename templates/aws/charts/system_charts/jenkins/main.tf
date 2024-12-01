# Jenkins Helm chart
## https://charts.jenkins.io
## https://artifacthub.io/packages/helm/jenkinsci/jenkins

resource "helm_release" "jenkins" {
  name             = var.name
  repository       = "https://charts.jenkins.io"
  chart            = "jenkins"
  version          = var.chart_version
  namespace        = var.namespace
  create_namespace = var.namespace == "kube-system" ? false : true
  wait             = true
  values           = [local.base_values]

}
