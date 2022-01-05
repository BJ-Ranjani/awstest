locals {
  nat_gateway_ips = split(
    ",",
    join(",", aws_eip.nat.*.id),
  )
}
resource "aws_internet_gateway" "this" {
  count = var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = format("%s", var.igw_name)
    },
    var.igw_tags,
  )
}
##############
# NAT Gateway
##############

resource "aws_eip" "nat" {
  count = var.create_eip_for_nat ? 1 : 0

  vpc = true

  tags = merge(
    {
      "Name" = var.eip_name,
    },
    var.nat_eip_tags,
  )
}

resource "aws_nat_gateway" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  allocation_id = var.use_existing_eip ? var.allocation_id : element(local.nat_gateway_ips, 0)
  subnet_id     = var.natgw_subnet

  tags = merge(
    {
      "Name" = var.ngw_name,

    },
    var.nat_gateway_tags,
  )

  depends_on = [aws_internet_gateway.this]
}



