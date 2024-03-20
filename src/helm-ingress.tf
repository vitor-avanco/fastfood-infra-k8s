resource "helm_release" "nginx_ingress" {
  provider = helm.fiap-cluster

  name      = "ingress-nginx"
  namespace = "kube-system"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.8.3"

  # Docs = https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx#configuration

  set {
    name  = "controller.service.type"
    value = "NodePort"
  }

  set {
    name  = "controller.service.nodePorts.http"
    value = var.eks_ingress_http_port
  }

  set {
    name  = "controller.service.nodePorts.https"
    value = var.eks_ingress_https_port
  }

  set {
    name  = "controller.ingressClassResource.default"
    value = "true"
  }
}
