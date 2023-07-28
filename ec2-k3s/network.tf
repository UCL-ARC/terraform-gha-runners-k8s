module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = "${var.aws_prefix}-vpc"
  cidr = var.cidr

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  map_public_ip_on_launch = true
}

resource "aws_security_group" "default" {
  name        = "${var.aws_prefix}-default-sg"
  description = "Default security group allowing egress only"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group_rule" "all_ingress_from_deployers_ip" {
  for_each          = { ssh = 22 }
  type              = "ingress"
  description       = "TLS"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["${data.http.deployer_ip.response_body}/32"]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "allow_k3s_private_networking" {
  type              = "ingress"
  description       = "TLS"
  from_port         = 0 # All
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["10.42.0.0/16", "10.43.0.0/16"]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "ingress_self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group" "node" {
  name        = "${var.aws_prefix}-node-sg"
  description = "Security group for node networking"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
