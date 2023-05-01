module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"   

  name = "${local.name}-${var.vpc_name}"
  cidr = var.vpc_cidr_block

  azs             = var.vpc_availability_zones
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway  
  single_nat_gateway = var.vpc_single_nat_gateway
 
  #We want to add database subnet -3 tier architecture
  create_database_subnet_group = var.vpc_create_database_subnet_group
  create_database_subnet_route_table = var.vpc_create_database_subnet_route_table
  database_subnets = var.vpc_database_subnets
    
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = local.common_tags
  vpc_tags = local.common_tags

  ##It is a good practice to tag your subnets in VPC
  public_subnet_tags = {
    Type = "Public Subnets"
  }

  private_subnet_tags = {
    Type = "Private Subnets"
  } 
  
  database_subnet_tags = {
    Type = "Private Database Subnets"
  }   
}
