output "region" {
  value = local.region
}

output "key_pair_name" {
    value = local.key_pair_name
}

output "vpc_cidr" {
  value = module.vpc.vpc_cidr_block
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_pub_cidr" {
  value = module.vpc.public_subnets
}

output "subnet_pri_cidr" {
  value = module.vpc.private_subnets
}

output "gitlab_security_group_id" {
  value = module.security.security_group_id
}

output "gitlab_external_ipaddr" {
  value = module.ec2_instance.public_ip
}