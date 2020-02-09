terraform {
  required_version = "0.12.19"
}

provider "aws" {
  version = "2.48.0"
  region  = "ap-northeast-1"
}

provider "http" {
  version = "1.1.0"
}

variable "ssh_public_key" {
  type = string
  description = "SSH Public Key"
}

# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html
data "aws_ami" "ubuntu_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-????????"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  owners = ["099720109477"] # Canonical
}

module "vpc_and_launch_template" {
  source                  = "../terraform"
  name                    = "example"
  availability_zones      = ["ap-northeast-1a"]
  image_id                = data.aws_ami.ubuntu_ami.image_id
  ssh_public_key          = var.ssh_public_key
  ssh_allowed_cidr_blocks = [format("%s/32", local.my_ip_addr)]
}

## Get My Public IP
## https://stackoverflow.com/questions/46763287/i-want-to-identify-the-public-ip-of-the-terraform-execution-environment-and-add
data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  my_ip_addr = jsondecode(data.http.my_public_ip.body).ip
}