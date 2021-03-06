terraform {
  required_providers {
    helm = ">= 1.0.0"
    kubernetes = ">= 1.10.0"
  }
}

locals {
  values_yaml_rendered = templatefile("./${path.module}/values.yaml.tpl", {
    controller_service  = var.controller_service,
    annotations         = var.annotations
  })
}

resource "kubernetes_namespace" "nginx_namespace" {
    metadata {
        annotations = {
            name = "nginx-ingress"
        }
        name = "nginx-ingress"
    }
}

data "helm_repository" "nginx-stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com/"
}

resource "helm_release" "nginx_release" {
    name        = "nginx-ingress"
    namespace   = kubernetes_namespace.nginx_namespace.metadata[0].name
    repository  = data.helm_repository.nginx-stable.url
    chart       = "nginx-ingress"
    timeout     = 600
    version     = "1.39.1"

    values      = [local.values_yaml_rendered]
}