variable "region" {
  default = "ap-northeast-2"
  type = string
}

variable "profile" {
  default = "mfa"
  type = string
}

variable "tfstate" {
  default = "bes-cm-ane2-tfstate"
  type = string
}

variable "tfstate_lock" {
  default = "bes-cm-ane2-lock"
  type = string
}

variable "tags" {
    default = {
        user: "hyunmin",
        enddate: "2023/12/31",
        purpose: "project dev"
    } 
    type = object({})
}