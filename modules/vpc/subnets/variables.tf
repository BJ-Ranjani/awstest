variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}


variable "intra_subnets" {
  description = "A list of intra subnets"
  type        = list(string)
  default     = []
}
variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  type        = bool
  default     = false
}
variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  type        = bool
  default     = true
}
variable "public_subnet_prefix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "public"
}

variable "private_subnet_prefix" {
  description = "Suffix to append to private subnets name"
  type        = string
  default     = "private"
}

variable "intra_subnet_prefix" {
  description = "Suffix to append to intra subnets name"
  type        = string
  default     = "intra"
}
variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = list(string)
  default     = ["", "", ""]
}
variable "private_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = list(string)
  default     = ["", "", ""]
}
variable "intra_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = list(string)
  default     = ["", "", ""]
}
variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}
variable "public_name" {
  description = "A list of public subnet names in the region"
  type        = list(string)
  default     = []
}
variable "private_name" {
  description = "A list of private subnet names in the region"
  type        = list(string)
  default     = []
}
variable "intra_name" {
  description = "A list of intra subnet names or ids in the region"
  type        = list(string)
  default     = []
}
variable "public_subnet_tags" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}
variable "intra_subnet_tags" {
  description = "Additional tags for the intra subnets"
  type        = map(string)
  default     = {}
}
variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}
variable "vpc_id" {
  description = "ID of the vpc to be associated with"
  type        = string
  default     = ""
}