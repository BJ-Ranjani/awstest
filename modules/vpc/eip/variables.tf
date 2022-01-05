variable "create_eip" {
  description = "Controls if an eip is created "
  type        = bool
  default     = true
}
variable "eip_name" {
  description = "Name to be used on the elastic IP as identifier"
  type        = string
  default     = ""
}
variable "nat_eip_tags" {
  description = "Additional tags for the NAT EIP"
  type        = map(string)
  default     = {}
}
variable "vpc" {
  description = "Boolean if the EIP is in a VPC or not"
  type        = bool
  default     = true
}

variable "instance" {
  description = "EC2 instance ID"
  type        = string
  default     = null
}

variable "network_interface" {
  description = "Network interface ID to associate with"
  type        = string
  default     = null
}

variable "associate_with_private_ip" {
  description = "A user specified primary or secondary private IP address to associate with the Elastic IP address. If no private IP address is specified, the Elastic IP address is associated with the primary private IP address."
  type        = string
  default     = null
}

variable "public_ipv4_pool" {
  description = "EC2 IPv4 address pool identifier or amazon. This option is only available for VPC EIPs."
  type        = string
  default     = null
}