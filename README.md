# terraform-gha-runners-k8s

## WIP

- Ephemeral, auto-scaling GitHub Actions runners on Kubernetes.
- Installs [actions-runner-controller](https://github.com/actions/actions-runner-controller)
  on Kubernetes via Terraform.

## Setting up a dev k3s instance with libvirt/KVM

The following instructions assume you are using a Ubuntu/Debian host:

```bash
# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# Install QEMU/KVM/libvirt
sudo apt install qemu-kvm virt-manager virtinst \
    libvirt-clients bridge-utils libvirt-daemon-system -y
sudo systemctl enable --now libvirtd
sudo systemctl start libvirtd
sudo usermod -aG kvm $USER
sudo usermod -aG libvirt $USER
# Config. network if required
sudo virsh net-dumpxml default > default.xml
sudo virsh net-define default.xml
sudo virsh net-start default
sudo virsh net-list
# Get k3os
wget https://github.com/rancher/k3os/releases/download/v0.22.2-k3s2r0/k3os-amd64.iso
# Create VM on KVM
virt-install --os-type linux --os-variant generic --name k3OS --vcpus=2 \
    --memory=8192 --disk k3os-disk1.qcow2,size=20 --network network=default \
    --autostart --graphics none --cdrom k3os-amd64.iso
```

At the shell of the VM, do the following to install to disk:

```bash
k3os-18181 [~]$ sudo k3os install

Running k3OS configuration
Choose operation
1. Install to disk
2. Configure server or agent
Select Number [1]: 1
Config system with cloud-init file? [y/N]: n
Authorize GitHub users to SSH? [y/N]: y
Comma separated list of GitHub users to authorize: bathomas
Configure WiFi? [y/N]: n
Run as server or agent?
1. server
2. agent
Select Number [1]: 1
Token or cluster secret (optional):

Configuration
-------------

device: /dev/sda

Your disk will be formatted and k3OS will be installed with the above configuration.
Continue? [y/N]: y
```

- Copy `/etc/rancher/k3s/k3s.yaml` on the VM to `~/.kube/config` on the host.
- Change the localhost IP in the `config` file to match the IP of the VM.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.7.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [kubectl_manifest.arc-install](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.cert-manager](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.runner-deploy](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.cert-manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.gha-ns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.runner-ns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.runner-secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [http_http.arc](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.cert-manager](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [kubectl_file_documents.arc-install](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |
| [kubectl_file_documents.cert-manager-install](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |
| [kubectl_file_documents.runner-deploy](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gh_pat_token"></a> [gh\_pat\_token](#input\_gh\_pat\_token) | GitHub PAT code with access to repo(s)/org. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
