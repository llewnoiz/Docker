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

module "ec2_instance" {
  source  = "./modules/terraform-aws-ec2-instance"
  ami           = data.aws_ami.ubuntu.id
  name = "${local.name}-gitlab-instance"
 
  instance_type          = local.gitlab_instance_type
  ignore_ami_changes = true
  key_name               = module.key_pair.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [module.security.security_group_id]

  subnet_id              = local.gitlab_external_ip ? element(module.vpc.public_subnets, 0): element(module.vpc.private_subnets, 0) 
  
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = local.gitlab_volume_size
    },
  ]
  
  associate_public_ip_address = local.gitlab_external_ip

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
  tags = local.tags
}

