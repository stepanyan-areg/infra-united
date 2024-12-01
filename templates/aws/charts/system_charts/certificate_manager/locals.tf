locals {
  base_values = yamldecode(
    templatefile("${path.module}/values.yaml", {})
  )

  merged_values = merge(
    local.base_values,
    var.extra_values
  )
}
