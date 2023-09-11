module "key_pair" {
  source = "./modules/terraform-aws-key-pair"

  key_name           = local.key_pair_name
  public_key = trimspace(tls_private_key.this.public_key_openssh)
  create_private_key = true
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "private_key_pem" {
  content = tls_private_key.this.private_key_pem
  file_permission = "0400"
  filename = "../${local.key_pair_name}"
}