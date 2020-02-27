resource "kubernetes_namespace" "nginx_namespace" {
    metadata {
        annotaions = {
            name = "nginx"
        }
        name = "nginx"
    }
}

provider "helm" {
    version        = "~> 1.0.0"

    kubernetes {
      host                   = module.k8s.host
      client_certificate     = base64decode(module.k8s.client_certificate)
      client_key             = base64decode(module.k8s.client_key)
      cluster_ca_certificate = base64decode(module.k8s.cluster_ca_certificate)
      load_config_file       = false
  }
}

data "helm_repository" "nginx-stable" {
  name = "nginx-stable"
  url  = "https://helm.nginx.com/stable"
}

resource "helm_release" "nginx_release" {
    name        = "nginx-ingress"
    namespace   = kubernetes_namespace.nginx_namespace.metadata.name
    repository  = data.helm_repository.nginx-stable.metadata[0].name
    chart       = "nginx-stable/nginx-ingress"
    timeout     = 600
}