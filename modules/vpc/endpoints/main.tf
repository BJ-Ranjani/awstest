######################
# VPC Endpoint for S3
######################
data "aws_vpc_endpoint_service" "s3" {
  count = var.enable_s3_endpoint ? 1 : 0

  service = var.service

  filter {
    name   = "service-type"
    values = [var.s3_endpoint_type]
  }
}

resource "aws_vpc_endpoint" "s3" {
  count = var.enable_s3_endpoint ? 1 : 0

  vpc_id       = var.vpc_id
  service_name = var.service_name_full

  vpc_endpoint_type   = var.s3_endpoint_type
  security_group_ids  = var.s3_endpoint_type == "Interface" ? var.s3_endpoint_security_group_ids : null
  subnet_ids          = var.s3_endpoint_type == "Interface" ? var.s3_endpoint_subnet_ids : null
  policy              = var.s3_endpoint_policy
  private_dns_enabled = var.s3_endpoint_type == "Interface" ? var.s3_endpoint_private_dns_enabled : null

  tags = var.vpce_tags
}

resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  count = var.enable_s3_endpoint && var.s3_endpoint_type == "Gateway" ? 1 : 0

  vpc_endpoint_id = aws_vpc_endpoint.s3[0].id
  route_table_id  = element(var.private_route_table_ids, count.index)
}

resource "aws_vpc_endpoint_route_table_association" "intra_s3" {
  count = var.enable_s3_endpoint && length(var.intra_subnets) > 0 && var.s3_endpoint_type == "Gateway" ? 1 : 0

  vpc_endpoint_id = aws_vpc_endpoint.s3[0].id
  route_table_id  = element(var.intra_route_table_ids, 0)
}

resource "aws_vpc_endpoint_route_table_association" "public_s3" {
  count = var.enable_s3_endpoint && var.s3_endpoint_type == "Gateway" ? 1 : 0

  vpc_endpoint_id = aws_vpc_endpoint.s3[0].id
  route_table_id  = element(var.public_route_table_ids, 0)
}