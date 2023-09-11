module "security" {
    source = "./modules/terraform-aws-security-group"

    name        = "${local.name}-gitlab-sg"
    description = "${local.name}-gitlab-sg"
    vpc_id      = module.vpc.vpc_id

    ingress_with_cidr_blocks = local.gitlab_security_ingress_rule
    egress_with_cidr_blocks = local.gitlab_security_egress_rule
}