terraform {
  required_version = ">= 1.5.0"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}
