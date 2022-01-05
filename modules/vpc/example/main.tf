#Adding code for mgmt-vpc
module "vpc" {
  source               = "../vpc"
  name                 = var.name_vpc
  cidr                 = var.cidr_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true

  vpc_tags = {
    Entity = "codepipes"
  }
}

module "subnet" {
  source                  = "../subnets"
  vpc_id                  = module.vpc.vpc_id
  map_public_ip_on_launch = true
  public_name             = var.public_name_sub
  azs                     = var.azs_sub
  public_subnets          = var.public_subnets_sub
  private_name            = var.private_name_sub
  private_subnets         = var.private_subnets_sub
  public_subnet_tags = {
    Entity = "codepipes"
  }
  private_subnet_tags = {
    Entity = "codepipes"
  }
}


module "igw_natgw" {
  source             = "../igw_and_natgw"
  igw_name           = var.igw_name
  ngw_name           = var.ngw_name
  eip_name           = var.eip_name
  vpc_id             = module.vpc.vpc_id
  natgw_subnet       = module.subnet.public_subnets[0]
  enable_nat_gateway = true
  single_nat_gateway = true
  azs                = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  public_subnets     = module.subnet.public_subnets
  private_subnets    = module.subnet.private_subnets
  igw_tags = {
    Entity = "codepipes"
  }
  nat_eip_tags = {
    Entity = "codepipes"
  }
  nat_gateway_tags = {
    Entity = "codepipes"
  }
}


module "nacl" {
  source  = "../nacl"
  vpc_id  = module.vpc.vpc_id
  subnets = concat(module.subnet.public_subnets, module.subnet.private_subnets)
  inbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
  ]
  outbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}
module "peering_default" {
  source                                    = "../peering"
  vpc_id                                    = module.vpc.vpc_id
  acceptor_vpc_id                           = "vpc-84cf32ef"
  auto_accept                               = true
  acceptor_allow_remote_vpc_dns_resolution  = true
  requestor_allow_remote_vpc_dns_resolution = true
  tags = {
    Entity = "codepipes"
  }
}

module "route_table" {
  source          = "../route_tables"
  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  vpc_id          = module.vpc.vpc_id
  igw_id          = module.igw_natgw.igw_id
  public_name     = ["mgmt-vpc-public-rt"]
  private_name    = ["mgmt-vpc-private-rt"]
  public_subnets  = module.subnet.public_subnets
  private_subnets = module.subnet.private_subnets
  nat_gateway_ids = module.igw_natgw.natgw_ids
  public_routes = [
    {
      destination_cidr_block    = "172.31.0.0/16"
      vpc_peering_connection_id = module.peering_default.connection_id
    },

  ]
  private_routes = [
    {
      destination_cidr_block    = "172.31.0.0/16"
      vpc_peering_connection_id = module.peering_default.connection_id
    },

  ]
  public_route_table_tags = {
    Entity = "codepipes"
  }
  private_route_table_tags = {
    Entity = "codepipes"
  }
}
