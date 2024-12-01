locals {
  values_yaml_path         = "${path.module}/yamls/values.yaml"
  ec2_node_class_yaml_path = "${path.module}/yamls/ec2nodeclass.yaml"
  node_pool_yaml_path      = "${path.module}/yamls/nodepool.yaml"

  base_values = templatefile(local.values_yaml_path, {
    release_name         = var.name
    region               = var.region
    cluster_name         = var.cluster_name
    sa_name              = var.serviceaccount
    cluster_endpoint     = var.cluster_endpoint
    karpenter_queue_name = module.karpenter.queue_name
    irsa_role            = module.karpenter.irsa_arn
    node_selector = jsonencode({ "nodeSelector" : merge({
      "kubernetes.io/os" : "linux",
      },
      var.has_dedicated_infra_nodes ? { "role" : "infra" } : {},
    ) })
  })

  ec2_node_class_yaml = templatefile(local.ec2_node_class_yaml_path, {
    role_name    = module.karpenter.role_name
    cluster_name = var.cluster_name
  })

  node_pool_yaml = templatefile(local.node_pool_yaml_path, {})

  karpenter_role_auth = [
    {
      rolearn  = module.karpenter.role_arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups = [
        "system:bootstrappers",
        "system:nodes",
      ]
    }
  ]

  existing_aws_auth = data.kubernetes_config_map_v1.aws_auth.data

  aws_auth_configmap_data = {
    mapRoles = yamlencode(concat(
      local.karpenter_role_auth,
      tolist(setsubtract(yamldecode(local.existing_aws_auth.mapRoles), local.karpenter_role_auth))

    ))
  }
}
