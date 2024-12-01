include "root" {
  path   = find_in_parent_folders()
  expose = true
}

# For AWS provider & tfstate S3 backand
include "cloud" {
  path = find_in_parent_folders("cloud.hcl")
}

dependency "zone_apprandom" {
  config_path = "../../../../../../../shared-resources-767397678436/aws/shared-resources/global/route53/qa.apprandom.com/"
}

terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-acm.git///?ref=v3.2.0"
}


inputs = {
  domain_name = dependency.zone_apprandom.outputs.route53_zone_name["qa.apprandom.com"]
  zone_id     = dependency.zone_apprandom.outputs.route53_zone_zone_id["qa.apprandom.com"]

  subject_alternative_names = [
    "*.qa.apprandom.com"
  ]

  wait_for_validation  = false
  validate_certificate = false

  tags = include.root.inputs.common_tags
}
