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
module "ec2module" {
   source = "./ec2"     ##Source, where the scripts are located
   ec2name = "Demo-ec2"  ## passing the value for the variable
}

output "module_output" {
  value = module.ec2module.instance_id
}
