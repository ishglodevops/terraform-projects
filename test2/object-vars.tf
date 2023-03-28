provider  "aws" {
   region ="us-east-1"
}

variable "subnet_prefix"  {
   description = "cidr block for the subnet" 
    #default 
}

resource "aws_vpc" "test_vpc" {
  cidr_block       = "10.0.0.0/16"
  
  tags = {
    Name = "mytestvpc"
  }
}


resource "aws_subnet" "test_subnet-1" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = var.subnet_prefix[0].cidr_block    
  availability_zone = "us-east-1c"  

  tags = {
    Name = var.subnet_prefix[0].name
  }
}

resource "aws_subnet" "test_subnet-2" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = var.subnet_prefix[1].cidr_block   
  availability_zone = "us-east-1c"  

  tags = {
    Name = var.subnet_prefix[1].name
  }
}
