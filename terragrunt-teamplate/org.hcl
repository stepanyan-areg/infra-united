locals {
  github_org_name = "Magen100"
  my_org          = basename(get_terragrunt_dir())

  # Github team where all Grafana admin users are located.
  github_grafana_admins_team = "grafana-admins"
  github_oauth_domains       = ["opsfleet.com", "mgnsecure.com"]

  argocd_backend_repos = [
    "gitops",
    "magen-auth-api",
    "magen-etl",
    "magen-hidden-hand-api",
    "magen-imager-api",
    "magen-lambda",
    "magen-reports-manager-api",
    "magen-research-tools-api",
    "queue-manager",
    "magen-auth-web",
    "magen-reports-manager-web",
    "magen-research-tools-web",
    "magen-hidden-hand-v1-web"
  ]

  argocd_scanners_repos = [
    "gitops",
    "scanner"
  ]
}
