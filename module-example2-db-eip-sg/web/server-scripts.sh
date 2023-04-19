#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start
sudo echo '<h1>Welcome to ISHGLO DEVOPS </h1>'|sudo tree /var/www/html/index.html
sudo mkdir /var/www/html/appl
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(250, 210, 210);"> <h1>Welcome to ISHGLO DEVOPS </h1> <p>Terraform Demo</p> <p> Application version: v1</p> </body></html>'|sudo tree /var/www/html/appl/index.html
sudo curl http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/appl/metadata.html
                     
                     