provider  "aws" {
   region ="us-east-1"
}


resource "aws_instance" "my-ec2-server" {
  ami           = data.aws_ami.amazonlinux2.id
  #instance_type = var.instance_type_list[1]
  instance_type = var.instance_type_map["qa"]
  #user_data = file("${path.module}/appl-install.sh")
  
  count = 3          #Determines the number of instance to create - This is called meta-argument
  tags = {
    "Name" = "Prod-${count.index}"   #Use the count to name/tag the instances, Prod-0,Prod-1,Prod-2
  }
}
