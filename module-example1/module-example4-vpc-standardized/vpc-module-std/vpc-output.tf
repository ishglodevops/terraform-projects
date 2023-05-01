##VPC Output Values

#VPC Name
output "vpc_id" {
  description = "VPC ID"
  value = module.vpc.vpc_id
}

#VPC CIDR Block
output "vpc_cidr_block" {
  description = "VPC CIDR Block"
  value = module.vpc.vpc_cidr_block 
}

#VPC AZ's
output "azs" {
  description = "VPC Availability Zones"
  value = module.vpc.azs
}

#VPC Public Subnets
output "vpc_public_subnets" {
  description = "list VPC Public Subnets"
  value = module.vpc.public_subnets 
}

#VPC Private Subnets
output "vpc_private_subnets" {
  description = "List VPC Private Subnets"
  value = module.vpc.private_subnets 
}

#VPC Database Subnets
output "vpc_database_subnets" {
  description = "list VPC Database Subnets"
  value = module.vpc.database_subnets 
}

#VPC  NAT Gateway Public IP
output "nat_public_ips" {
  description = "List of NAT Elastic IP's"
  value = module.vpc.nat_public_ips 
}