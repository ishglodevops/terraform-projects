provider  "aws" {
   region ="us-east-1"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  
  dynamic ingress {
    iterator      = port       #This is what does the looping
    for_each      = var.ingressrules    #variable
    content {
      from_port     = port.value
      to_port       = port.value
      protocol      = "tcp"
      cidr_blocks   = ["0.0.0.0/0"]
    }
  }
  dynamic egress {
    iterator       = port
    for_each       = var.egressrules
    content {
      from_port      = port.value
      to_port        = port.value
      protocol       = "tcp"
      cidr_blocks    = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "allow_tls"
  }
}
