variable "name" {
  type        = string
  description = "Name attached to resource"
}

variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR Block"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  type        = list(string)
  description = "Subnet Availability Zones"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "Public Subnet CIDR Blocks"
  default     = []
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "Public Subnet CIDR Blocks"
  default     = ["10.0.1.0/24"]
}

variable "enable_nat_gateway" {
  type        = bool
  description = "enable NAT Gateway if true"
  default     = false
}

variable "image_id" {
  type        = string
  description = "AMI ImageId"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH Public Key"
}

variable "ssh_allowed_cidr_blocks" {
  type        = list(string)
  description = "SSH Allowed CIDR Blocks"
  default     = []
}
