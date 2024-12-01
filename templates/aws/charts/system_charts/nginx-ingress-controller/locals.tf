locals {
  base_values = yamldecode(
    templatefile("${path.module}/values.yaml", {
      toleration_value    = var.toleration_value
      node_selector_key   = var.node_selector_key
      node_selector_value = var.node_selector_value
    })
  )

  merged_values = merge(
    local.base_values,
    var.extra_values
  )
}
