locals {
  ec2_username = "ec2-user"
}

resource "aws_instance" "node" {
  ami           = var.ami
  instance_type = var.node_instance_type
  key_name      = var.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  tags = {
    Name = "${var.aws_prefix}-k3s-node${var.index}"
  }

  user_data = templatefile(
    "${path.module}/cloud_init.template.sh",
    {
      k3s_version    = var.k3s_version
      k3s_server_url = "https://${var.server_private_ip}:6443"
      k3s_token      = var.k3s_token
    }
  )

  root_block_device {
    volume_size = 30 # GB
    volume_type = "gp3"
  }
}
