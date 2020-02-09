# terraform

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| availability\_zones | Subnet Availability Zones | `list(string)` | n/a | yes |
| enable\_nat\_gateway | enable NAT Gateway if true | `bool` | `false` | no |
| image\_id | AMI ImageId | `string` | n/a | yes |
| name | Name attached to resource | `string` | n/a | yes |
| private\_subnet\_cidr\_blocks | Public Subnet CIDR Blocks | `list(string)` | `[]` | no |
| public\_subnet\_cidr\_blocks | Public Subnet CIDR Blocks | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]<br></pre> | no |
| ssh\_allowed\_cidr\_blocks | SSH Allowed CIDR Blocks | `list(string)` | `[]` | no |
| ssh\_public\_key | SSH Public Key | `string` | n/a | yes |
| vpc\_cidr\_block | VPC CIDR Block | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| launch\_template\_id | n/a |
| launch\_template\_latest\_version | n/a |
| private\_subnet\_ids | Private Subnet Ids |
| public\_subnet\_ids | Public Subnet Ids |
| security\_group\_id | ID of the Security Group that is attached to Launch Template Network Interface |