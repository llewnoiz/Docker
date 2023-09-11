output "tfstate" {
  value = aws_s3_bucket.tfstate.bucket
}

output "tfstate_lock" {
  value = aws_dynamodb_table.terraform_state_lock.name
}

output "region" {
  value = local.region
}