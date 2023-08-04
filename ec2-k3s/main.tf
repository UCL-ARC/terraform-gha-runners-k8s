terraform {
  required_version = ">= 1.2.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }

    external = {
      source  = "hashicorp/external"
      version = "2.3.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

locals {
  ec2_username             = "ec2-user"
  ssh_key_name             = "ec2_id_rsa"
  server_username_and_host = "${local.ec2_username}@${aws_instance.server.public_ip}"
  ssh_args                 = "-i ${local_sensitive_file.ssh_private_key_pem.filename} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
  ssh_command              = "ssh ${local.ssh_args} ${local.server_username_and_host}"
}

output "server_ssh_command" {
  value = local.ssh_command
}

output "server_username_and_host" {
  value = local.server_username_and_host
}

output "server_ssh_args" {
  value = local.ssh_args
}
