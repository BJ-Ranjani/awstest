cidr_vpc = "172.28.0.0/16"
name_vpc = "mgmt-vpc"

public_name_sub     = ["cp-public-subnet", "cp-public-subnet-2", "cp-public-subnet-3"]
azs_sub             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
public_subnets_sub  = ["172.28.0.0/24", "172.28.6.0/24", "172.28.5.0/24"]
private_name_sub    = ["cp-private-subnet-1", "cp-private-subnet-2", "cp-private-subnet-3"]
private_subnets_sub = ["172.28.12.0/24", "172.28.13.0/24", "172.28.14.0/24"]

igw_name = "cp-vpc-igw"
ngw_name = "cp-vpc-ngw"
eip_name = "cp-vpc-ngw-eip"