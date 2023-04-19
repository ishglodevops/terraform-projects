##Terraform block
terraform {
  required_version = "~> 1.3" 
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

##Terraform providers
provider "aws" {
    region = "us-east-1"   
}

##Module block
module "db" {
   source = "./db"         
}

module "web" {
   source = "./web"         
}

output "PrivateIP" {
  value = module.db.PrivateIP
}

output "PublicIP" {
  value = module.web.pub_ip
}
