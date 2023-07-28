terraform {
  required_version = ">= 1.2.0"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.10.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.22.0"
    }
  }
}

provider "kubernetes" {
  # Defaults to picking up $KUBE_CONFIG_PATH
  #config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
}

data "http" "cert-manager-crds" {
  url = "https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.crds.yaml"
}

data "kubectl_file_documents" "cert-manager-crds-install" {
  content = data.http.cert-manager-crds.response_body
}

resource "kubectl_manifest" "cert-manager-crds" {
  for_each  = data.kubectl_file_documents.cert-manager-crds-install.manifests
  yaml_body = each.value

  depends_on = [kubernetes_namespace.cert-manager]
}

resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io/"
  chart      = "cert-manager"
  version    = "v1.12.0"
  namespace  = kubernetes_namespace.cert-manager.metadata[0].name
}

resource "kubernetes_namespace" "runner-ns" {
  metadata {
    name = "actions-runner-system"
  }
}

resource "kubernetes_secret" "runner-secret" {
  metadata {
    name      = "controller-manager"
    namespace = kubernetes_namespace.runner-ns.metadata[0].name
  }

  data = {
    github_token = var.gh_pat_token
  }

  type = "Opaque"

  depends_on = [
    kubernetes_namespace.runner-ns
  ]
}

resource "helm_release" "arc" {
  name       = "arc"
  repository = "https://actions-runner-controller.github.io/actions-runner-controller"
  chart      = "actions-runner-controller"
  version    = "0.23.3"
  namespace  = kubernetes_namespace.runner-ns.metadata[0].name

  depends_on = [
    helm_release.cert-manager,
    kubernetes_secret.runner-secret
  ]
}

resource "kubernetes_namespace" "gha-ns" {
  metadata {
    name = "runners"
  }
}

#data "kubectl_file_documents" "runner-deploy" {
#  content = file("./runner-deployment.yaml")
#}
#
#resource "kubectl_manifest" "runner-deploy" {
#  for_each  = data.kubectl_file_documents.runner-deploy.manifests
#  yaml_body = each.value
#
#  depends_on = [
#    helm_release.arc
#  ]
#}
