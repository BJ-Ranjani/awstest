################
#Publiс routes
################
resource "aws_route_table" "public" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = var.public_name[count.index]
    },
    var.public_route_table_tags,
  )
}

resource "aws_route" "public_internet_gateway" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id

  timeouts {
    create = "5m"
  }

}

resource "aws_route" "public_route" {
  count = length(var.public_routes) > 0 ? length(var.public_routes) : 0

  route_table_id            = aws_route_table.public[0].id
  destination_cidr_block    = lookup(var.public_routes[count.index], "destination_cidr_block", null)
  vpc_peering_connection_id = lookup(var.public_routes[count.index], "vpc_peering_connection_id", null)

}



#################
# Private routes
#################
resource "aws_route_table" "private" {
  count = length(var.private_subnets) > 0 ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(
    {
      "Name" = var.private_name[count.index]
    },
    var.private_route_table_tags
  )
}
resource "aws_route" "private_nat_gateway" {
  count = length(var.private_subnets) > 0 ? 1 : 0

  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.nat_gateway_ids[0]

  timeouts {
    create = "5m"
  }
}
resource "aws_route" "private_route" {
  count = length(var.private_routes) > 0 ? length(var.private_routes) : 0

  route_table_id            = aws_route_table.private[0].id
  destination_cidr_block    = lookup(var.private_routes[count.index], "destination_cidr_block", null)
  vpc_peering_connection_id = lookup(var.private_routes[count.index], "vpc_peering_connection_id", null)

}

#################
# Intra routes
#################
//resource "aws_route_table" "intra" {
//  count = length(var.intra_subnets) > 0 ? 1 : 0
//
//  vpc_id = var.vpc_id
//
//  tags = merge(
//  {
//    "Name" = var.intra_name[count.index]
//  },
//  var.intra_route_table_tags,
//  )
//}
//
//resource "aws_route" "intra_route" {
//  count = length(var.intra_routes) > 0 ? length(var.intra_routes) : 0
//
//  route_table_id         = aws_route_table.private[0].id
//  destination_cidr_block = lookup(var.intra_routes[count.index], "destination_cidr_block", null)
//  vpc_peering_connection_id = lookup(var.intra_routes[count.index], "vpc_peering_connection_id", null)
//
//}

##########################
# Route table association
##########################
resource "aws_route_table_association" "private" {
  count = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  subnet_id = element(var.private_subnets, count.index)
  route_table_id = element(
    aws_route_table.private.*.id,
    var.single_nat_gateway ? 0 : count.index,
  )
}
//resource "aws_route_table_association" "intra" {
//  count = length(var.intra_subnets) > 0 ? length(var.intra_subnets) : 0
//
//  subnet_id      = element(var.intra_subnets, count.index)
//  route_table_id = element(aws_route_table.intra.*.id, 0)
//}
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  subnet_id      = element(var.public_subnets, count.index)
  route_table_id = aws_route_table.public[0].id
}


