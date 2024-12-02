terraform {
  source = "${get_repo_root()}/templates/aws/eks"
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

dependency "vpc" {
  config_path  = "../../vpc"
  mock_outputs = {
    vpc_id             = "vpc-1234"
    vpc_cidr_block     = "10.0.0.0/16"
    public_subnets     = ["subnet-1", "subnet-2", "subnet-3"]
    private_subnets    = ["subnet-4", "subnet-5", "subnet-6"]
  }
}

locals {
  my_env               = include.root.locals.my_env_conf.locals.my_env
  my_stack             = include.root.locals.my_stack_conf.locals.my_stack
  cluster_name         = "eks-${local.my_env}"
  sso_admin_iam_role_arn = include.root.locals.my_account_conf.locals.sso_admin_iam_role_arn
}

inputs = {
  environment              = local.my_env
  vpc                      = dependency.vpc.outputs.vpc_id
  subnets                  = dependency.vpc.outputs.private_subnets
  cluster_name             = local.cluster_name
  kube_version             = "1.31"
  sso_admin_role_arn       = local.sso_admin_iam_role_arn
}
