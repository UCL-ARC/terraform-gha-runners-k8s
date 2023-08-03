# ec2-k3s

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.7.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | 2.3.1 |
| <a name="requirement_null"></a> [null](#requirement\_null) | 3.2.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.7.0 |
| <a name="provider_external"></a> [external](#provider\_external) | 2.3.1 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.0 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.4.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.2.1 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_node"></a> [node](#module\_node) | ./node | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_instance.server](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/instance) | resource |
| [aws_key_pair.ssh](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/key_pair) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/security_group) | resource |
| [aws_security_group.node](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.all_ingress_from_deployers_ip](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_k3s_private_networking](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress_self](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/resources/security_group_rule) | resource |
| [local_file.ssh_public_key_openssh](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_sensitive_file.ssh_private_key_pem](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [null_resource.save_token](https://registry.terraform.io/providers/hashicorp/null/3.2.1/docs/resources/resource) | resource |
| [tls_private_key.global_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.rhel9](https://registry.terraform.io/providers/hashicorp/aws/5.7.0/docs/data-sources/ami) | data source |
| [external_external.server_data](https://registry.terraform.io/providers/hashicorp/external/2.3.1/docs/data-sources/external) | data source |
| [http_http.deployer_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_prefix"></a> [aws\_prefix](#input\_aws\_prefix) | Prefix to use when naming AWS resources | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `"eu-west-2"` | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | n/a | `string` | `"10.0.0.0/16"` | no |
| <a name="input_k3s_version"></a> [k3s\_version](#input\_k3s\_version) | n/a | `string` | `"v1.27.3+k3s1"` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | n/a | `number` | `2` | no |
| <a name="input_server_instance_type"></a> [server\_instance\_type](#input\_server\_instance\_type) | n/a | `string` | `"t3a.large"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_server_ssh_args"></a> [server\_ssh\_args](#output\_server\_ssh\_args) | n/a |
| <a name="output_server_ssh_command"></a> [server\_ssh\_command](#output\_server\_ssh\_command) | n/a |
| <a name="output_server_username_and_host"></a> [server\_username\_and\_host](#output\_server\_username\_and\_host) | n/a |
<!-- END_TF_DOCS -->
