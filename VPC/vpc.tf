provider  "aws" {
   region ="us-east-1"
}

resource "aws_vpc" "first_vpc" {
  cidr_block       = "10.0.0.0/16"
  
  tags = {
    Name = "myvpc"
  }
}
resource "aws_subnet" "first_subnet-1" {
  vpc_id     = aws_vpc.first_vpc.id   ##generated future vpc_id
  cidr_block = "10.0.1.0/24" ##IP has to fall within the VPC cidr IP range /16=2^16, /24=2^8

  tags = {
    Name = "mysubnet1"
  }
}
