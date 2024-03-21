terraform {
  backend "s3" {
    bucket         = "767397811632-terraform-backend"
    key            = "github/vitor-avanco/fastfood-infra-k8s"
    dynamodb_table = "767397811632-terraform-backend"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      terraform = "true"
    }
  }
}

provider "helm" {
  alias = "fiap-cluster"
  kubernetes {
    host                   = aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}