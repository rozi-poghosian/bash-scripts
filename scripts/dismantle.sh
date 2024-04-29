#!/bin/bash
sudo systemctl stop apache2
sudo rm -rf /var/www/html/*
sudo apt-get remove apache2 wget unzip -y

