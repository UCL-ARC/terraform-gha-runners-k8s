# terraform-gha-runners-k8s

> [!WARNING]\
> This repository is a work in progress

- Ephemeral, auto-scaling GitHub Actions runners on Kubernetes.
- Installs [actions-runner-controller](https://github.com/actions/actions-runner-controller)
  on Kubernetes via Terraform.

## Usage

This repository contains terraform for deploying a [k3s](https://k3s.io/)
cluster on EC2 instances which can be used to test the [actions-runner-controller
deployment](./gha-runners).

### Create a `.env` file

Create a `.env` file from `.env.sample`. Terraform variables (e.g. `TF_VAR_x`)
will be prompted for if unset.

#### Required variables

- `REPOSITORIES`: A comma seperated list of repositories e.g. `octo-org/octo-repoA,octo-org/octo-repoB`

### Deploy

```bash
make ec2-k3s         # Deploy the k3s cluster
make ec2-k3s-ssh     # SSH onto the server instance
make gha-runners     # Deploy the GitHub runners
kubectl get pods -A  # Check the runner pods are up
```

## gha-runners

<!-- BEGIN_TF_DOCS -->
{{ .Content }}
<!-- END_TF_DOCS -->
