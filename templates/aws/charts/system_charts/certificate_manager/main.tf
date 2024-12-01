# Copyright (c) 2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
#

# Cert Manager Helm chart
## https://github.com/jetstack/cert-manager/blob/master/README.md
## https://artifacthub.io/packages/helm/cert-manager/cert-manager
resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = var.chart_repository
  chart            = "cert-manager"
  version          = var.chart_version
  create_namespace = var.namespace == "kube-system" ? false : true
  namespace        = var.namespace
  wait             = true # wait to allow the webhook be properly configured
  values           = [yamlencode(local.merged_values)]

}

resource "helm_release" "cluster_issuers" {
  name      = "cert-manager-cluster-issuers"
  chart     = "${path.module}/issuers"
  namespace = var.namespace

  set {
    name  = "issuer.email"
    value = var.ingress_email_issuer
  }

  depends_on = [helm_release.cert_manager]
}
