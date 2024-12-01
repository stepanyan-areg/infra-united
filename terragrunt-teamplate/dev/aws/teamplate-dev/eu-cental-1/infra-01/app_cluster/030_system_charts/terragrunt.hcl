terraform {
  source = "${get_repo_root()}/templates/aws/charts/system_charts"
}

# For Inputs
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

# For AWS provider & tfstate S3 backand
include "cloud" {
  path = find_in_parent_folders("cloud.hcl")
}

# For Helm, Kubectl & GitHub providers
include "common_providers" {
  path = find_in_parent_folders("providers.hcl")
}

dependency "eks" {
  config_path  = "../010_eks"
  mock_outputs = {
    # vpc_id                    = "vpc-1234"
    eks_endpoint              = "https://example.com/eks"
    cluster_name          = "test_cluster"
    eks_oidc_provider         = "arn::test"
    eks_oidc_issuer_url       = "https://"
    # has_dedicated_infra_nodes = false
  }
  mock_outputs_merge_strategy_with_state = "deep_map_only"
  mock_outputs_allowed_terraform_commands = ["init", "validate"]
}

# dependency "zone_apprandom" {
#   config_path = "../../../../../../../shared-resources-767397678436/aws/shared-resources/global/route53/dev.apprandom.com/"
# }

# dependency "irsa_external_dns" {
#   config_path = "../../../../../../../shared-resources-767397678436/aws/shared-resources/global/irsa/external-dns-dev-scanners/"
# }

# dependency "acm_apprandom" {
#   config_path = "../../acm/dev.apprandom.com"
# }

locals {
  my_region = include.root.locals.my_region_conf.locals.my_region
}

inputs = {
  region                                       = local.my_region
  cluster_name                                 = dependency.eks.outputs.cluster_name
  cluster_endpoint                             = dependency.eks.outputs.eks_endpoint
  # vpc_id                                       = dependency.eks.outputs.vpc_id
  # domain_name                                  = dependency.zone_apprandom.outputs.route53_zone_name["dev.apprandom.com"]
  # acm_certificate_arn                          = dependency.acm_apprandom.outputs.acm_certificate_arn
  # cluster_oidc_provider                        = dependency.eks.outputs.eks_oidc_provider

  # has_dedicated_infra_nodes                    = dependency.eks.outputs.has_dedicated_infra_nodes

  # Cluster Autoscaler
  cluster_autoscaler_enabled                   = false
  cluster_autoscaler_namespace                 = "cluster-autoscaler"

  # Karpenter Autoscaler
  karpenter_enabled                            = false
  karpenter_namespace                          = "karpenter"

  # ALB Contorller
  alb_controller_enabled                       = false
  alb_controller_namespace                     = "alb-controller"
  # vpc_id                                       = dependency.eks.outputs.vpc_id

  # Kong
  kong_enabled                                 = false
  kong_namespace                               = "kong"

  # External DNS
  eks_external_dns_enabled                     = false
  external_dns_namespace                       = "external-dns"
  # external_dns_domain_filter                   = dependency.zone_apprandom.outputs.route53_zone_name["dev.apprandom.com"]
  # override_irsa_role                           = dependency.irsa_external_dns.outputs.roles["external-dns"].iam_role_arn

  # External Secrets
  external_secrets_enabled                     = false
  external_secrets_namespace                   = "external-secrets"

  # EBS CSI Driver
  ebs_csi_enabled                              = true
  ebs_csi_driver_namespace                     = "kube-system"

  # Metrics Server
  metrics_server_enabled                       = true
  metrics_server_namespace                     = "kube-system"

  # Node Trmination Handler
  aws_node_termination_handler_enabled         = false
  aws_node_termination_handler_namespace       = "kube-system"

  #Keda
  keda_enabled                                 = false
  keda_namespace                               = "keda"
  enable_keda_poc                              = true

  #reloader
  reloader_enabled                             = false
  reloader_namespace                           = "reloader"

  #ingress_inginx
  ingress_nginx_enabled            = true
  ingress_nginx_release_name       = "ingress-nginx"
  ingress_nginx_namespace          = "ingress-nginx"
  ingress_nginx_chart_version      = "4.11.2"  # Specify desired chart version
  ingress_nginx_chart_repository   = "https://kubernetes.github.io/ingress-nginx"
  ingress_nginx_toleration_value   = "infra"
  ingress_nginx_node_selector_key  = "karpenter.sh/nodepool"
  ingress_nginx_node_selector_value = "infra"

  # Additional values to override or add
  ingress_nginx_extra_values = {
    controller = {
      replicaCount = 2
      service = {
        annotations = {
        }
      }
    }
  }


  #Cert-Manager
  cert_manager_enabled  = true
  cert_manager_namespace = "cert-manager"
  cert_manager_helm_chart_version = "v1.15.3"
  ingress_email_issuer  = "aregstepanyan1@gmail.com"

  # jenkins.hcl
  jenkins_enabled              = false
  jenkins_release_name         = "jenkins"
  jenkins_namespace            = "jenkins"
  jenkins_chart_version        = "4.1.3" # Specify the desired chart version
  jenkins_domain_name          = "jenkins.ags-it.lol"
  jenkins_tls_cluster_issuer   = "letsencrypt-prod"
  jenkins_admin_user           = "admin"
  jenkins_admin_password       = "supersecret" # Consider using environment variables or a secrets manager
  jenkins_storage_class        = "gp2"
  jenkins_storage_size         = "10Gi"
  has_dedicated_infra_nodes    = false


}
