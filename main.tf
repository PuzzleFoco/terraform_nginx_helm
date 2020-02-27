resource "kubernetes_namespace" "nginx_namespace" {
    metadata {
        annotations = {
            name = "nginx"
        }
        name = "nginx"
    }
}

data "helm_repository" "nginx-stable" {
  name = "nginx-stable"
  url  = "https://helm.nginx.com/stable"
}

resource "helm_release" "nginx_release" {
    provider    = var.alias
    name        = "nginx-ingress"
    namespace   = kubernetes_namespace.nginx_namespace.metadata[0].name
    repository  = data.helm_repository.nginx-stable.metadata[0].name
    chart       = "nginx-stable/nginx-ingress"
    timeout     = 600
}