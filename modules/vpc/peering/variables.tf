variable "enable" {
  description = "Controls if VPC peering is created."
  type        = bool
  default     = true
}
variable "peer_region" {
  type        = string
  description = "Region of the peer"
  default     = ""
}
variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = ""
}

variable "acceptor_vpc_id" {
  type        = string
  description = "Acceptor VPC ID"
  default     = ""
}


variable "tags" {
  type        = map(string)
  description = "Acceptor VPC tags"
  default     = {}
}

variable "auto_accept" {
  type        = bool
  default     = null
  description = "Automatically accept the peering (both VPCs need to be in the same AWS account)"
}

variable "acceptor_allow_remote_vpc_dns_resolution" {
  type        = bool
  default     = null
  description = "Allow acceptor VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the requestor VPC"
}

variable "requestor_allow_remote_vpc_dns_resolution" {
  type        = bool
  default     = true
  description = "Allow requestor VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the acceptor VPC"
}
