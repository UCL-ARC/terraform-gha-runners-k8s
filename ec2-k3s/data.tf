data "aws_ami" "rhel9" { # Amazon machine image
  most_recent = true

  filter {
    name   = "name"
    values = ["RHEL-9.*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

data "http" "deployer_ip" {
  url = "https://api64.ipify.org"
}
