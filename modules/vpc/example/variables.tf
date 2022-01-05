variable "name_vpc" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "cidr_vpc" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "public_subnets_sub" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets_sub" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "azs_sub" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}
variable "public_name_sub" {
  description = "A list of public subnet names in the region"
  type        = list(string)
  default     = []
}
variable "private_name_sub" {
  description = "A list of private subnet names in the region"
  type        = list(string)
  default     = []
}

variable "igw_name" {
  description = "Name to be used on the internet gateway as identifier"
  type        = string
  default     = ""
}
variable "eip_name" {
  description = "Name to be used on the elastic IP as identifier"
  type        = string
  default     = ""
}
variable "ngw_name" {
  description = "Name to be used on the nat gateway as identifier"
  type        = string
  default     = ""
}