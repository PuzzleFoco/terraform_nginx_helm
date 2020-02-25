provider "helm" {
    version        = "~> 0.10.4"
    install_tiller = true

    kubernetes {
      host                   = var.host
      client_certificate     = var.client_certificate
      client_key             = var.client_key
      cluster_ca_certificate = var.cluster_ca_certificate
  }
}

data "helm_repository" "nginx-stable" {
  name = "nginx-stable"
  url  = "https://helm.nginx.com/stable"
}

resource "helm_release" "nginx_release" {
    name        = "nginx_ingress"
    namespace   = "nginx_ingress"
    repository  = data.helm_repository.nginx-stable.metadata[0].name
    chart       = "nginx-stable/nginx-ingress"
    timeout     = 600
}