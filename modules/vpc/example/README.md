# Description
This module is used to create vpc and its components

## Usage

```terraform
provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "~/.aws/credentials"
}

module "vpc" {
  source = "../modules/vpc/vpc/"
  name = "terraform-test"
  cidr = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  vpc_tags = {
    Owner = "user"
    Environment = "dev"
    Name = "example"
  }
}

module "subnets" {
  source = "../modules/vpc/subnets/"
  name = "terraform-test"
  vpc_id = module.vpc.vpc_id
  map_public_ip_on_launch = true
  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  public_subnet_tags = {
    Owner = "user"
    Environment = "dev"
  }
  private_subnet_tags = {
    Owner = "user"
    Environment = "dev"
  }
}

module "igw_natgw" {
  source = "../modules/vpc/igw_and_natgw"
  name = "terraform-test"
  vpc_id = module.vpc.vpc_id
  enable_nat_gateway = true
  single_nat_gateway = true
  azs = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  public_subnets  = module.subnets.public_subnets
  private_subnets = module.subnets.private_subnets
  igw_tags = {
    Owner = "user"
    Environment = "dev"
  }
  nat_eip_tags = {
    Owner = "user"
    Environment = "dev"
  }
  nat_gateway_tags = {
    Owner = "user"
    Environment = "dev"
  }
}

module "rtb" {
  source = "../modules/vpc/route_tables/"
  name = "terraform test"
  azs  = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  vpc_id = module.vpc.vpc_id
  igw_id = module.igw_natgw.igw_id
  public_subnets = module.subnets.public_subnets
  private_subnets = module.subnets.private_subnets
  nat_gateway_ids = module.igw_natgw.natgw_ids
  public_route_table_tags = {
    Owner = "user"
    Environment = "dev"
  }
  private_route_table_tags = {
    Owner = "user"
    Environment = "dev"
  }
}

module "nacl" {
  source = "../modules/vpc/nacl"
  vpc_id = module.vpc.vpc_id
  name = "terraform-test"
  public_subnets = module.subnets.public_subnets
  private_subnets = module.subnets.private_subnets
  public_acl_tags = {
    Owner = "user"
    Environment = "dev"
  }
  private_acl_tags = {
    Owner = "user"
    Environment = "dev"
  }

}

```
