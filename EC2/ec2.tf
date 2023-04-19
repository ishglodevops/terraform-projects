provider  "aws" {
   region ="us-east-1"
}

resource "aws_instance" "my-ec2-server" {
  ami           = "ami-005f9685cb30f234b"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}

