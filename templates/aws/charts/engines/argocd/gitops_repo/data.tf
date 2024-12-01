data "github_user" "current" {
  username = ""
}

data "github_repository" "gitops" {
  full_name = "${var.github_org_name}/${var.github_repo_name}"
}