variable "aws_prefix" {
  type        = string
  description = "Prefix to use when naming AWS resources"
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "k3s_version" {
  type    = string
  default = "v1.27.3+k3s1"
}

variable "server_instance_type" {
  type    = string
  default = "t3a.large"
}

variable "node_count" {
  type    = number
  default = 2
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}
