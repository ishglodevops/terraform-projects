data "aws_ami" "amzlinux2" {
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
