terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }

  backend "s3" {
    bucket = "ishglo-myterraform-tfstate"
    key = "global/s3/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    region = "us-east-1"
    encrypt = true
  } 
}

resource "aws_dynamodb_table" "tf_lock" {
  name = "terraform-lock"
  hash_key = "LockID"  
  read_capacity = 3
  write_capacity = 3
  attribute {
    name ="LockID" 
    type = "S"
  }
  tags = {
   Name = "terraform Lock Table"
  }
  lifecycle {
    prevent_destroy = true
  }
} 

provider "aws" {
 region = "us-east-1"
}
