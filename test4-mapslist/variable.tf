variable "instance_type_list" {
  description = "EC2 Instance Type"
  type = list(string)
  default = ["t2.micro","t2.medium","t3.large"]
}

variable "instance_type_map" {
  description = "EC2 Instance Type"
  type = map(string)
  default = {
    "dev"  = "t2.micro"
    "qa"    = "t2.medium"
    "prod" = "t3.large"
  }
}

data "aws_ami" "amazonlinux2" {
  ## executable_users = ["self"]
  most_recent      = true
  ##name_regex       = "^myami-\\d{3}"   ##You can search by using regular expressions, we won’t use it
  owners           = ["amazon"]
  
  filter {                          ##All the filter are just there to refine your search
    name = "name"
    values = ["amzn2-ami-hvm-*-gp2"]
  }
  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}


variable "my-key-pair" {
   description = "The ec2 keypair"
   type = string
   default = "devops"  
}