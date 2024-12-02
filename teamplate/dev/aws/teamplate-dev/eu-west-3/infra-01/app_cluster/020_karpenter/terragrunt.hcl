# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "${get_repo_root()}/templates/aws//karpenter"
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

# # For Helm, Kubectl & GitHub providers
# include "common_providers" {
#   path = find_in_parent_folders("providers.hcl")
# }

dependency "eks" {
  config_path  = "../010_eks"
  mock_outputs = {
    eks_endpoint              = "https://example.com/eks"
    cluster_name          = "test_cluster"
    eks_oidc_provider         = "arn::test"
    eks_oidc_issuer_url       = "https://"
  }
  mock_outputs_merge_strategy_with_state = "deep_map_only"
  mock_outputs_allowed_terraform_commands = ["init", "validate"]
}

locals {
  my_region    = include.root.locals.my_region_conf.locals.my_region
  my_env       = include.root.locals.my_env_conf.locals.my_env
}

dependency "eks" {
  config_path  = "../010_eks"
}

dependency "vpc" {
  config_path = "../../vpc"
}

inputs = {
  region             = local.my_region
  environment        = local.my_env
  cluster_name       = dependency.eks.outputs.cluster_name
  oidc_provider      = dependency.eks.outputs.oidc_provider
  oidc_provider_arn  = dependency.eks.outputs.oidc_provider_arn
  private_subnet_ids = dependency.vpc.outputs.private_subnets
  cluster_endpoint   = dependency.eks.outputs.eks_endpoint
}
