#!/bin/bash

echo ""
echo -e "\nbuild docker hadoop image\n"
sudo docker build -t jiangshouzhuang/hadoop2.7.3-cluster-on-docker .
echo ""