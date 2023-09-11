terraform {

  backend "s3" {    
    bucket    = "bes-cm-ane2-tfstate"
    key    ="bes-cm-ane2-tfstate/gitlab"
    region = "ap-northeast-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
