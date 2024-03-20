data "aws_security_group" "eks_cluster" {
  tags = {
    "kubernetes.io/cluster/${aws_eks_cluster.this.name}" = "owned"
    "Name"                                               = "eks-cluster-sg-${aws_eks_cluster.this.name}-*"
  }
}

resource "aws_security_group_rule" "eks_cluster_nginx_ingress_http" {
  type              = "ingress"
  from_port         = var.eks_ingress_http_port
  to_port           = var.eks_ingress_http_port
  protocol          = "tcp"
  cidr_blocks       = [module.vpc.vpc_cidr_block] # VPC Link ENI is in VPC CIDR Block
  security_group_id = data.aws_security_group.eks_cluster.id
}

resource "aws_security_group_rule" "eks_cluster_nginx_ingress_https" {
  type              = "ingress"
  from_port         = var.eks_ingress_https_port
  to_port           = var.eks_ingress_https_port
  protocol          = "tcp"
  cidr_blocks       = [module.vpc.vpc_cidr_block] # VPC Link ENI is in VPC CIDR Block
  security_group_id = data.aws_security_group.eks_cluster.id
}
