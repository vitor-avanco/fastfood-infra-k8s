variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "eks_cluster_name" {
  type    = string
  default = "fastfood-cluster"
}

variable "eks_ingress_http_port" {
  type    = number
  default = 32080
}

variable "eks_ingress_https_port" {
  type    = number
  default = 32443
}