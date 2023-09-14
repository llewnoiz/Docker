resource "aws_ebs_volume" "this" {
  availability_zone = module.ec2_instance.availability_zone
  size              = local.gitlab_volume_size
  tags = local.tags
}

resource "aws_volume_attachment" "this" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.this.id
  instance_id = module.ec2_instance.id
}