resource "aws_vpc_peering_connection" "this" {
  count       = var.enable ? 1 : 0
  vpc_id      = var.vpc_id
  peer_vpc_id = var.acceptor_vpc_id
  peer_region = var.peer_region

  auto_accept = var.auto_accept

  //  accepter {
  //    allow_remote_vpc_dns_resolution = var.acceptor_allow_remote_vpc_dns_resolution
  //    allow_classic_link_to_remote_vpc = null
  //    allow_vpc_to_remote_classic_link = null
  //  }

  requester {
    allow_remote_vpc_dns_resolution = var.requestor_allow_remote_vpc_dns_resolution
  }

  tags = var.tags

}
