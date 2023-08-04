# gha-runners

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.10.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.10.1 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.7.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.22.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.arc](https://registry.terraform.io/providers/hashicorp/helm/2.10.1/docs/resources/release) | resource |
| [helm_release.cert-manager](https://registry.terraform.io/providers/hashicorp/helm/2.10.1/docs/resources/release) | resource |
| [kubectl_manifest.cert-manager-crds](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.auto_scalers](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/manifest) | resource |
| [kubernetes_manifest.deployments](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/manifest) | resource |
| [kubernetes_namespace.cert-manager](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/namespace) | resource |
| [kubernetes_namespace.gha-ns](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/namespace) | resource |
| [kubernetes_namespace.runner-ns](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/namespace) | resource |
| [kubernetes_secret.runner-secret](https://registry.terraform.io/providers/hashicorp/kubernetes/2.22.0/docs/resources/secret) | resource |
| [http_http.cert-manager-crds](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [kubectl_file_documents.cert-manager-crds-install](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gh_pat_token"></a> [gh\_pat\_token](#input\_gh\_pat\_token) | GitHub PAT code with access to repo(s)/org. | `string` | n/a | yes |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | Comma separated list of repositories to create runners for | `string` | n/a | yes |
<!-- END_TF_DOCS -->
