

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.21.0"

  name = var.name

  cidr = "10.0.0.0/16"
  azs = [
    "ap-northeast-1a",
  ]

  public_subnets = [
    "10.0.1.0/24"
  ]

  enable_nat_gateway   = false
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_security_group" "this" {
  name   = var.name
  vpc_id = module.vpc.vpc_id
  tags = merge(
    {
      Name = var.name
    }
  )
}

resource "aws_security_group_rule" "allow_ssh_access" {
  description       = "allow ssh"
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  cidr_blocks       = var.ssh_allowed_cidr_blocks
  from_port         = 22
  to_port           = 22
  type              = "ingress"
}

resource "aws_security_group_rule" "allow_accesss_to_the_internet" {
  description       = "allow access to the Internet"
  protocol          = "-1"
  security_group_id = aws_security_group.this.id
  cidr_blocks = [
    "0.0.0.0/0"
    ]
  from_port = 0
  to_port   = 0
  type      = "egress"
}

resource "aws_launch_template" "this" {

  name = var.name

  ebs_optimized = false

  image_id = var.image_id

  instance_market_options {
    market_type = "spot"
  }

  vpc_security_group_ids = [aws_security_group.this.id]

  key_name = aws_key_pair.this.key_name
}

resource "aws_key_pair" "this" {
  key_name   = var.name
  public_key = var.ssh_public_key
}
