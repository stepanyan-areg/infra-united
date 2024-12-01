locals {
  # r53_hosted_zone_name = "dev-scanners.mgnsecure.com"
  my_account           = basename(get_terragrunt_dir())
  # sso_admin_iam_role_arn = "arn:aws:iam::905418195280:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AdministratorAccess_f229e7b6a7f478e8"
}
