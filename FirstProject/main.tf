provider  "aws" {
   region ="us-east-1"
}

resource "aws_vpc" "test_vpc" {
  cidr_block       = "10.0.0.0/16"
  
  tags = {
    Name = "mytestvpc"
  }
}


resource "aws_internet_gateway" "test_gw" {
	vpc_id = aws_vpc.test_vpc.id
	
	tags = {
	 Name = "test-gw"
	}
}


resource "aws_route_table" "test_route-table" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"  #default – send to all traffic
    gateway_id = aws_internet_gateway.test_gw.id
  }

  route {
    ipv6_cidr_block        = "::/0" #IPv6 -send to all IPv6 trafiic
    
    gateway_id = aws_internet_gateway.test_gw.id
  }

  tags = {
    Name = "test-routetable"
  }
}


resource "aws_subnet" "test_subnet-1" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.1.0/24" 
  availability_zone = "us-east-1c"  ##always better to hardcode the AZ to avoid resource in different AZ’s

  tags = {
    Name = "test-subnet-1"
  }
}


resource "aws_route_table_association" "test-rtassoc" {
  subnet_id      = aws_subnet.test_subnet-1.id
  route_table_id = aws_route_table.test_route-table.id
}


resource "aws_security_group" "test-SG-1" {
  name        = "allow_web"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.test_vpc.id

  ingress {
    description = "https traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Not a good idea,better use on IP in your VPC or work
  }
  
  ingress {
    description = "http traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Not a good idea,better use on IP in your VPC or work
  }

  ingress {
    description = "ssh traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Not a good idea,better use on IP in your VPC or work
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"   ##means any protocol, tcp,udp etc
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    Name = "test-SG-1"
  }
}



resource "aws_network_interface" "test-webserver-nic" {
  subnet_id       = aws_subnet.test_subnet-1.id
  private_ips     = ["10.0.1.50"] ##Assign Any IP within the subnet IP, eg 10.0.1.50 
  security_groups = [aws_security_group.test-SG-1.id]

}


resource "aws_eip" "test-eip" {
  vpc                       = true  ##means the eip is in the vpc
  network_interface         = aws_network_interface.test-webserver-nic.id
  associate_with_private_ip = "10.0.1.50" ##the IP in the aws_network_interface
  depends_on = [aws_internet_gateway.test_gw] #exception, needs dependency of gw
}


resource "aws_instance" "my-web-server" {
  ami           = "ami-0557a15b87f6559cf"  ##Ami for ubuntu
  instance_type = "t2.micro"
  availability_zone = "us-east-1c"  ##always better to hardcode the AZ to avoid resource in different AZ’s
  key_name = "devops" 
  
  network_interface {
      device_index = 0
       network_interface_id = aws_network_interface.test-webserver-nic.id
}
 
 user_data = <<-EOF
                #!/bin/bash
                sudo 
                sudo apt update -y
                sudo apt install apache2 -y
                sudo systemctl start apache2
                sudo bash -c "echo Ishglo first terraform exercise-fun,fun>/var/www/html/index.html"
                EOF

 tags = {
    Name = "my-web-server"
   }
 }

output "server_public_IP" {
    value = aws_eip.test-eip.public_ip
}

output "server_private_IP" {
    value = aws_instance.my-web-server.private_ip
}

output "server_id" {
    value = aws_instance.my-web-server.id
}