
# Configure the AWS Provider
provider "aws" {
  profile = local.profile
  region = local.region
}