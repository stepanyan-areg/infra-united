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

locals {
  my_env       = include.root.locals.my_env_conf.locals.my_env
}

dependency "eks" {
  config_path  = "../010_eks"
}

dependency "vpc" {
  config_path = "../../vpc"
}

inputs = {
  environment        = local.my_env
  cluster_name       = dependency.eks.outputs.cluster_name
  oidc_provider      = dependency.eks.outputs.oidc_provider
  oidc_provider_arn  = dependency.eks.outputs.oidc_provider_arn
  private_subnet_ids = dependency.vpc.outputs.private_subnets
}
