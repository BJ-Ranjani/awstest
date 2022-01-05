variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  type        = bool
  default     = false
}
variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
  default     = []
}
variable "public_subnet_suffix" {
  description = "Suffix to append to public subnets name"
  type        = string
  default     = "public"
}
variable "private_subnet_suffix" {
  description = "Suffix to append to private subnets name"
  type        = string
  default     = "private"
}

variable "intra_subnet_suffix" {
  description = "Suffix to append to intra subnets name"
  type        = string
  default     = "intra"
}
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

variable "public_route_table_tags" {
  description = "Additional tags for the public route tables"
  type        = map(string)
  default     = {}
}

variable "private_route_table_tags" {
  description = "Additional tags for the private route tables"
  type        = map(string)
  default     = {}
}


variable "intra_route_table_tags" {
  description = "Additional tags for the intra route tables"
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
variable "igw_id" {
  description = "ID of the internet gateway to be associated with"
  type        = string
  default     = ""
}
variable "nat_gateway_ids" {
  description = "A list of nat gateway ids to be attached to the private route"
  type        = list(string)
  default     = []
}
variable "public_routes" {
  description = "Public routes in public route table"
  type        = list(map(string))

  default = [
    {
      destination_cidr_block    = null
      vpc_peering_connection_id = null
    },
  ]
}
variable "private_routes" {
  description = "Public routes in public route table"
  type        = list(map(string))

  default = [
    {
      destination_cidr_block    = null
      vpc_peering_connection_id = null
    },
  ]

}
variable "intra_routes" {
  description = "Public routes in public route table"
  type        = list(map(string))

  default = [
    {
      destination_cidr_block    = null
      vpc_peering_connection_id = null
    },
  ]

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