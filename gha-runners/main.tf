terraform {
  required_version = ">= 1.2.0"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "cert-manager" {
  metadata {
    name = "cert-manager"
  }
}

data "http" "cert-manager" {
  url = "https://github.com/cert-manager/cert-manager/releases/download/v1.11.0/cert-manager.yaml"
}

data "kubectl_file_documents" "cert-manager-install" {
  content = data.http.cert-manager.response_body
}

resource "kubectl_manifest" "cert-manager" {
  for_each  = data.kubectl_file_documents.cert-manager-install.manifests
  yaml_body = each.value
}

resource "kubernetes_namespace" "runner-ns" {
  metadata {
    name = "actions-runner-system"
  }
}

resource "kubernetes_secret" "runner-secret" {
  metadata {
    name      = "controller-manager"
    namespace = "actions-runner-system"
  }

  data = {
    github_token = "${var.gh_pat_token}"
  }

  type = "Opaque"

  depends_on = [
    kubernetes_namespace.runner-ns
  ]
}

data "http" "arc" {
  url = "https://github.com/actions/actions-runner-controller/releases/download/v0.25.2/actions-runner-controller.yaml"
}

data "kubectl_file_documents" "arc-install" {
  content = data.http.arc.response_body
}

resource "kubectl_manifest" "arc-install" {
  for_each  = data.kubectl_file_documents.arc-install.manifests
  yaml_body = each.value

  depends_on = [
    kubectl_manifest.cert-manager,
    kubernetes_secret.runner-secret
  ]

  server_side_apply = true
}

resource "kubernetes_namespace" "gha-ns" {
  metadata {
    name = "runners"
  }
}

data "kubectl_file_documents" "runner-deploy" {
  content = file("./runner-deployment.yaml")
}

resource "kubectl_manifest" "runner-deploy" {
  for_each  = data.kubectl_file_documents.runner-deploy.manifests
  yaml_body = each.value

  depends_on = [
    kubectl_manifest.arc-install
  ]

}
