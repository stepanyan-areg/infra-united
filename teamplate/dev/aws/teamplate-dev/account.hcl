locals {
  my_account           = basename(get_terragrunt_dir())
  sso_admin_iam_role_arn = "arn:aws:iam::813640746877:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AdministratorAccess_e16c8993724b66b4"
}
