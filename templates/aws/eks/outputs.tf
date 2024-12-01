output "cluster_name" {
  value = module.eks.cluster_name
}

output "oidc_provider" {
    value = module.eks.oidc_provider
}

output "oidc_provider_arn" {
    value = module.eks.oidc_provider_arn
}

output "eks_certificate" {
    value = module.eks.cluster_certificate_authority_data
}

output "eks_endpoint" {
    value = module.eks.cluster_endpoint
}


# output "node_iam_role_arn" {
#   value = module.eks.node_groups["initial"].iam_role_arn
# }

