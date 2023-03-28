#!/bin/bash
sudo hostnamectl set-hostname webserv1
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start apache2
sudo bash -c "echo Ishglo first terraform exercise-fun,fun>/var/www/html/index.html"
