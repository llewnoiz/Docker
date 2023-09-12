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

variable "key_pair_name" {
  default = "bes-cm-ane2-key"
  type = string
}

variable "project_name" {
  default = "bes-cm-gitlab"
  type = string
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
  type = string
}

variable "gitlab_security_group_name" {
  default = "gitlab security"
  type = string
}

variable "gitlab_instance_type" {
  default = "m5.large"
  type = string
}

variable "gitlab_volume_size" {
  default = 50
  type = number
}


variable "gitlab_external_ip" {
  default = true
  type = bool
}
variable "gitlab_security_ingress_rule" {
  default = [
        {
        from_port   = 422
        to_port     = 422
        protocol    = "tcp"
        description = "git"
        cidr_blocks = "0.0.0.0/0"
        },
        {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        description = "ssh"
        cidr_blocks = "0.0.0.0/0"
        },
        {
        from_port   = 8929
        to_port     = 8929
        protocol    = "tcp"
        description = "web service"
        cidr_blocks = "0.0.0.0/0"
        }
    ]
  
}

variable "gitlab_security_egress_rule" {
  default = [
    {
        from_port   = -1
        to_port     = -1
        protocol    = "-1"
        description = "egress"
        cidr_blocks = "0.0.0.0/0"
        }
  ]
}

variable "user_data" {
  default = <<-EOT
    #!/bin/bash
    sudo apt-get update -y
    sudo apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update -y
    sudo apt install -y docker-ce docker-ce-cli containerd.io git
    sudo service docker start
    sudo systemctl enable docker.service
    sudo systemctl restart docker.service   
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod 755 /usr/local/bin/docker-compose
    mkdir -p /home/gitlab
    git clone https://github.com/llewnoiz/Docker.git /home/gitlab
    cd /home/gitlab/gitlab
    sudo chmod 755 * -R
    sudo docker-compose -f ./docker-compose.yml up -d    
  EOT 
}