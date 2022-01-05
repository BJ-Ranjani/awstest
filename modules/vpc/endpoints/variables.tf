variable "enable_s3_endpoint" {
  description = "Should be true if you want to provision an S3 endpoint to the VPC"
  type        = bool
  default     = false
}

variable "s3_endpoint_type" {
  description = "S3 VPC endpoint type. Note - S3 Interface type support is only available on AWS provider 3.10 and later"
  type        = string
  default     = "Gateway"
}
variable "vpce_tags" {
  description = "Additional tags for the VPC"
  type        = map(string)
  default     = {}
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
variable "s3_endpoint_security_group_ids" {
  description = "The ID of one or more security groups to associate with the network interface for S3 interface endpoint"
  type        = list(string)
  default     = []
}

variable "s3_endpoint_subnet_ids" {
  description = "The ID of one or more subnets in which to create a network interface for S3 interface endpoint. Only a single subnet within an AZ is supported. If omitted, private subnets will be used."
  type        = list(string)
  default     = []
}

variable "s3_endpoint_private_dns_enabled" {
  description = "Whether or not to associate a private hosted zone with the specified VPC for S3 interface endpoint"
  type        = bool
  default     = false
}

variable "s3_endpoint_policy" {
  description = "A policy to attach to the endpoint that controls access to the service. Defaults to full access"
  type        = string
  default     = null
}
variable "service" {
  description = "service type"
  type        = string
  default     = "s3"
}
variable "service_name_full" {
  description = "service type"
  type        = string
  default     = null
}


variable "intra_subnets" {
  description = "A list of intra subnets"
  type        = list(string)
  default     = []
}
variable "enable_public_s3_endpoint" {
  description = "Whether to enable S3 VPC Endpoint for public subnets"
  default     = true
  type        = bool
}
variable "public_route_table_ids" {
  description = "A list of public subnet ids inside the VPC"
  type        = list(string)
  default     = []
}
variable "private_route_table_ids" {
  description = "A list of private subnet ids inside the VPC"
  type        = list(string)
  default     = []
}
variable "intra_route_table_ids" {
  description = "A list of intra subnet ids inside the VPC"
  type        = list(string)
  default     = []
}
variable "vpc_id" {
  description = "Name of the vpc to be associated with"
  type        = string
  default     = ""
}