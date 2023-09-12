data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  region = var.region
  profile = var.profile
  tags = var.tags
  tfstate = var.tfstate
  tfstate_lock = var.tfstate_lock
  name = var.project_name  

  vpc_cidr = var.vpc_cidr
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
  key_pair_name = var.key_pair_name

  gitlab_ami = data.aws_ami.ubuntu.id
  gitlab_instance_type = var.gitlab_instance_type
  gitlab_security_egress_rule = var.gitlab_security_egress_rule
  gitlab_security_ingress_rule = var.gitlab_security_ingress_rule
  gitlab_volume_size = var.gitlab_volume_size
  gitlab_external_ip = var.gitlab_external_ip

  user_data= var.user_data

}