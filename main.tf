
data "google_client_config" "current" {}

provider "helm" {
    version = "~>0.10"
    install_tiller = true

    kubernetes {
      host                   = var.host
      client_certificate     = var.client_certificate
      client_key             = var.client_key
      cluster_ca_certificate = var.cluster_ca_certificate
      token                  = "${data.google_client_config.current.access_token}"
  }
}

data "helm_repository" "nginx-stable" {
  name = "nginx-stable"
  url  = "https://helm.nginx.com/stable"
}

resource "helm_release" "nginx_release" {
    name        = "nginx-ingress"
    namespace   = "nginx-ingress"
    repository  = data.helm_repository.nginx-stable.metadata[0].name
    chart       = "nginx-stable/nginx-ingress"
    timeout     = 600
}