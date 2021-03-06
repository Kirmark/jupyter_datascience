#!/bin/bash

pwd
whoami

## Настрйока проекта

sudo apt-get update
sudo apt-get install unzip

#yes Y | sudo rm -r notebooks
mkdir notebooks
sudo chgrp 100 notebooks
sudo chmod g+w notebooks
echo "vm.overcommit_memory=1" | sudo tee -a /etc/sysctl.conf

## Докер

if [ "$1" != "-r" ]; then
  yes Y | sudo apt-get remove docker docker-engine docker.io
  yes Y | sudo apt install docker.io
fi

sudo systemctl start docker
sudo systemctl enable docker
docker --version

sudo docker build -t jupyter_datascience ./

sudo docker kill jupyter_datascience_instance
sudo docker rm jupyter_datascience_instance

sudo docker run -it -p 8888:8888 --privileged --name jupyter_datascience_instance -v $(pwd)/notebooks:/home/jovyan/work jupyter_datascience:latest
