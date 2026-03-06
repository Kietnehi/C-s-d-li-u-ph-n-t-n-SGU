#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo chown $USER ~/.ssh/config
sudo chmod 644 ~/.ssh/config
sudo docker build -t kiwenlau/hadoop:1.0 .

echo ""