resource "kubernetes_service_account" "tiller" {
  metadata {
    name      = "tiller"
    namespace = "kube-system"

    annotations = {
      managed_by_terraform = true
    }
  }
}

resource "kubernetes_cluster_role_binding" "cluster_admins" {
  metadata {
    name = "tiller-cluster-admins"
  }

  role_ref {
    kind      = "ClusterRole"
    name      = "cluster-admin"
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.tiller.metadata.0.name
    namespace = kubernetes_service_account.tiller.metadata.0.namespace
  }
}

provider "helm" {
    version = "~>0.10"
    namespace      = kubernetes_service_account.tiller.metadata.0.namespace
    service_account = kubernetes_service_account.tiller.metadata.0.name

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
    name        = "nginx-ingress"
    namespace   = "nginx-ingress"
    repository  = data.helm_repository.nginx-stable.metadata[0].name
    chart       = "nginx-stable/nginx-ingress"
    timeout     = 600
}