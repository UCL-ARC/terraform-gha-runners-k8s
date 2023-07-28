module "node" {
  count = length(module.vpc.private_subnets) > 0 ? var.node_count : 0

  source             = "./node"
  ami                = data.aws_ami.rhel9.id
  availability_zone  = module.vpc.azs[count.index % length(module.vpc.private_subnets)]
  aws_prefix         = var.aws_prefix
  k3s_token          = data.external.server_data.result.token
  k3s_version        = var.k3s_version
  security_group_ids = [aws_security_group.default.id, aws_security_group.node.id]
  subnet_id          = module.vpc.private_subnets[count.index % length(module.vpc.private_subnets)]
  server_private_ip  = aws_instance.server.private_ip
  index              = count.index
  key_name           = aws_key_pair.ssh.key_name
  node_instance_type = var.server_instance_type
}
