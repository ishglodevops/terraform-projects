provider  "aws" {
   region ="us-east-1"
}

resource "aws_instance" "my-ec2-server" {
  ami           = data.aws_ami.amazonlinux2.id
  instance_type = "t2.micro"
  user_data = file("${path.module}/appl-install.sh")
  key_name = var.my-key-pair

  tags = {
    Name = "HelloWorld"
  }
}
