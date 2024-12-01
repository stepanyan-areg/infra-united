resource "aws_ecr_repository" "ecr_repository" {
  for_each = local.repositories
  name     = each.key

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = var.tags
}

resource "aws_ecr_lifecycle_policy" "default_policy" {
  for_each   = local.repositories
  repository = aws_ecr_repository.ecr_repository[each.key].name

  policy = jsonencode({ rules = concat(local.untagged_images_rule, local.pull_request_images_rule) }) #local.remove_max_images_rule

  depends_on = [
    aws_ecr_repository.ecr_repository
  ]
}

resource "aws_ecr_repository_policy" "cross_account_policy" {
  for_each   = var.enable_cross_account_access ? local.repositories : {}
  repository = aws_ecr_repository.ecr_repository[each.key].name

  policy = jsonencode({
    Version = "2008-10-17"
    Statement = [
      {
        Sid    = "AllowCrossAccountPull"
        Effect = "Allow"
        Principal = {
          AWS = var.external_account_ids
        }
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:GetDownloadUrlForLayer"
        ]
      }
    ]
  })

  depends_on = [
    aws_ecr_repository.ecr_repository
  ]
}