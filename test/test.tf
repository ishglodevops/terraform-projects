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
  cidr_block = var.subnet_prefix
  availability_zone = "us-east-1c"  ##always better to hardcode the AZ to avoid resource in different AZ’s

  tags = {
    Name = "test-subnet-1"
  }
}

