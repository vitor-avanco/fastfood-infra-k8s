resource "aws_lb" "eks_ingress" {
  name               = "eks-ingress"
  internal           = true
  load_balancer_type = "network"
  security_groups    = []
  subnets            = module.vpc.private_subnets

  #   access_logs {
  #     bucket  = aws_s3_bucket.lb_logs.id
  #     prefix  = "test-lb"
  #     enabled = true
  #   }
}

resource "aws_lb_listener" "eks_ingress_listener" {
  load_balancer_arn = aws_lb.eks_ingress.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks_ingress_target_group.arn
  }
}

resource "aws_lb_target_group" "eks_ingress_target_group" {
  name     = "eks-ingress-target-group"
  port     = var.eks_ingress_http_port
  protocol = "TCP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_autoscaling_attachment" "eks_ingress_target_group_attachment" {
  autoscaling_group_name = aws_eks_node_group.this.resources[0].autoscaling_groups[0].name
  lb_target_group_arn    = aws_lb_target_group.eks_ingress_target_group.arn
}
