########################
#Network ACLs
########################
resource "aws_network_acl" "this" {
  count = length(var.subnets) > 0 ? 1 : 0

  vpc_id     = var.vpc_id
  subnet_ids = var.subnets

  tags = var.tags
}

resource "aws_network_acl_rule" "inbound" {
  count = length(var.subnets) > 0 ? length(var.inbound_acl_rules) : 0

  network_acl_id = aws_network_acl.this[0].id

  egress      = false
  rule_number = var.inbound_acl_rules[count.index]["rule_number"]
  rule_action = var.inbound_acl_rules[count.index]["rule_action"]
  from_port   = lookup(var.inbound_acl_rules[count.index], "from_port", null)
  to_port     = lookup(var.inbound_acl_rules[count.index], "to_port", null)
  protocol    = var.inbound_acl_rules[count.index]["protocol"]
  cidr_block  = lookup(var.inbound_acl_rules[count.index], "cidr_block", null)
}

resource "aws_network_acl_rule" "outbound" {
  count = length(var.subnets) > 0 ? length(var.outbound_acl_rules) : 0

  network_acl_id = aws_network_acl.this[0].id

  egress      = true
  rule_number = var.outbound_acl_rules[count.index]["rule_number"]
  rule_action = var.outbound_acl_rules[count.index]["rule_action"]
  from_port   = lookup(var.outbound_acl_rules[count.index], "from_port", null)
  to_port     = lookup(var.outbound_acl_rules[count.index], "to_port", null)
  protocol    = var.outbound_acl_rules[count.index]["protocol"]
  cidr_block  = lookup(var.outbound_acl_rules[count.index], "cidr_block", null)
}


