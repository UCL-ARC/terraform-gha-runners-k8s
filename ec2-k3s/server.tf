resource "aws_instance" "server" {
  ami           = data.aws_ami.rhel9.id
  instance_type = var.server_instance_type
  key_name      = aws_key_pair.ssh.key_name

  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.default.id]

  tags = {
    Name = "${var.aws_prefix}-k3s-server"
  }

  user_data = templatefile(
    "${path.module}/cloud_init.template.sh",
    {
      k3s_version = var.k3s_version
    }
  )

  root_block_device {
    volume_size = 30 # GB
    volume_type = "gp3"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'"
    ]

    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = local.ec2_username
      private_key = tls_private_key.global_key.private_key_pem
    }
  }

  depends_on = [
    aws_security_group_rule.all_ingress_from_deployers_ip,
    module.vpc
  ]
}

resource "null_resource" "save_token" {
  provisioner "local-exec" {
    command = <<EOF
until ${local.ssh_command} /usr/local/bin/k3s --version; do sleep 10; done
token=$(${local.ssh_command} sudo /usr/local/bin/k3s token create --ttl 5h)
echo {\"token\": \"$token\"} > ${path.module}/token.json
EOF
  }
}

data "external" "server_data" {
  program    = ["cat", "${path.module}/token.json"]
  depends_on = [null_resource.save_token]
}
