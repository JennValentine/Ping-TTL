#!/bin/bash

cd /opt
sudo rm -rf Ping-TTL
sudo git clone https://github.com/JennValentine/Ping-TTL
sudo chmod +x Ping-TTL/*
cd Ping-TTL
ls -lthas
cd /opt/Ping-TTL
sudo cp pttl.sh pttl_$RANDOM.sh
sudo mv pttl.sh pttl
sudo rm -rf /usr/local/bin/pttl
sudo mv pttl /usr/local/bin/
ls -lthas
cd