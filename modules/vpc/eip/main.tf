resource "aws_eip" "this" {
  count = var.create_eip ? 1 : 0

  vpc                       = var.vpc
  instance                  = var.instance
  network_interface         = var.network_interface
  associate_with_private_ip = var.associate_with_private_ip
  public_ipv4_pool          = var.public_ipv4_pool

  tags = merge(
    {
      "Name" = var.eip_name,
    },
    var.nat_eip_tags,
  )
}