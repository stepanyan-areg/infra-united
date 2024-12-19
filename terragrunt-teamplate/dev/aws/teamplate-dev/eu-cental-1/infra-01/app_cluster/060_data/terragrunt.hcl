terraform {
  source = "${get_repo_root()}/templates/aws/charts/data"
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
    vpc_id              = "vpc-1234"
    eks_endpoint        = "https://example.com/eks"
    eks_cluster_name    = "test_cluster"
    eks_oidc_provider   = "arn::test"
    eks_oidc_issuer_url = "https://"
    has_dedicated_infra_nodes = true
  }
  mock_outputs_merge_strategy_with_state = "deep_map_only"
  mock_outputs_allowed_terraform_commands = ["init", "validate"]
}

dependency "zone_apprandom" {
  config_path = "../../../../../../../shared-resources-767397678436/aws/shared-resources/global/route53/apprandom.com/"
}

dependency "acm_apprandom" {
  config_path = "../../acm/apprandom.com"
}

locals {
  my_region         = include.root.locals.my_region_conf.locals.my_region
}

inputs = {
  region                                   = local.my_region
  cluster_name                             = dependency.eks.outputs.eks_cluster_name
  vpc_id                                   = dependency.eks.outputs.vpc_id
  domain_name                              = dependency.zone_apprandom.outputs.route53_zone_name["apprandom.com"]
  acm_certificate_arn                      = dependency.acm_apprandom.outputs.acm_certificate_arn
  cluster_oidc_provider                    = dependency.eks.outputs.eks_oidc_provider

  redis_enabled                   = true
  redis_namespace                 = "redis"
  redis_values_override           = <<EOT
master:
  nodeSelector:
    role: data
  topology.kubernetes.io/zone: us-east-1a
  resources:
    requests:
      cpu: 1500m
      memory: 8Gi
      ephemeral-storage: 100Mi
    # limits:
     # cpu: 2500m
     # memory: 3072Mi
     # ephemeral-storage: 3Gi
  extraFlags:
    - "--maxmemory 6869501440"
    - "--maxmemory-policy volatile-ttl"
replica:
  nodeSelector:
    role: data
  topology.kubernetes.io/zone: us-east-1a
  resources:
    requests:
      cpu: 1000m
      memory: 8Gi
      ephemeral-storage: 100Mi
    # limits:
     # cpu: 2500m
     # memory: 3072Mi
     # ephemeral-storage: 3Gi
  extraFlags:
    - "--maxmemory 6869501440"
    - "--maxmemory-policy volatile-ttl"
EOT

  mongodb_cluster_enabled                 = true
  mongodb_cluster_namespace               = "mongodb-cluster"
  mongodb_cluster_chart_version           = "15.6.14"
  mongodb_cluster_values_override         = <<EOT
podAntiAffinityPreset: soft
nodeSelector:
  role: data
  topology.kubernetes.io/zone: us-east-1a
persistence:
  size: 20Gi
resources:
  requests:
    cpu: 1000m
    memory: 2048Mi
    ephemeral-storage: 100Mi
  limits:
    cpu: 1500m
    memory: 3072Mi
    ephemeral-storage: 3Gi
EOT
}
