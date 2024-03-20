terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0, < 6.0.0"
    }

    helm = {
      source = "hashicorp/helm"
      # version = ">= 2.0.0, < 3.0.0"
      # Fixing version due Helm problems (https://github.com/hashicorp/terraform-provider-helm/issues/893)
      version = "= 2.5.1"
    }
  }
}
