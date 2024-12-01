terraform {
  source = "tfr:///cloudposse/ec2-client-vpn/aws?version=1.0.0"
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
  config_path  = "../vpc"
  mock_outputs = {
    vpc_id             = "vpc-1234"
    public_subnets     = ["subnet-1", "subnet-2", "subnet-3"]
    private_subnets    = ["subnet-4", "subnet-5", "subnet-6"]
    r53_parent_zone_id = "zone_id"
    azs                = ["az1", "az2", "az3"]
  }
}

locals {
  my_env               = include.root.locals.my_env_conf.locals.my_env
  my_stack             = include.root.locals.my_stack_conf.locals.my_stack
  my_region            = include.root.locals.my_region_conf.locals.my_region
  my_account           = include.root.locals.my_account_conf.locals.my_account
  r53_hosted_zone_name = include.root.locals.my_account_conf.locals.r53_hosted_zone_name
}

inputs = {
  vpc_id     = dependency.vpc.outputs.vpc_id
  region     = local.my_region
  associated_subnets = dependency.vpc.outputs.private_subnets

  name = "${local.my_account}-vpn-client"

  ca_common_name     = "vpn.${local.r53_hosted_zone_name}"
  root_common_name   = "vpn-client.${local.r53_hosted_zone_name}"
  server_common_name = "vpn-server.${local.r53_hosted_zone_name}"

  client_cidr = "10.5.240.0/22"

  target_cidr_block = dependency.vpc.outputs.vpc_cidr_block

  logging_stream_name = "client_vpn"

  logging_enabled = false

  retention_in_days = 0

  organization_name = "ultrared"
  
  availability_zones = dependency.vpc.outputs.azs
  allowed_cidr_blocks = ["0.0.0.0/0"]

  associated_security_group_ids = []

  authorization_rules = [{
    name                 = "full access"
    authorize_all_groups = true
    description          = "Full access"
    target_network_cidr  = dependency.vpc.outputs.vpc_cidr_block
  }
  ]

  additional_routes = [
    {
      destination_cidr_block = "0.0.0.0/0"
      description            = "Internet Route"
      target_vpc_subnet_id   = element(dependency.vpc.outputs.private_subnets, 0)
    }
  ]

  split_tunnel = true

  export_client_certificate = true

  tags = include.root.inputs.common_tags
}