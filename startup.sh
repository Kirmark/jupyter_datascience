#!/bin/bash

pwd
whoami

## Настрйока проекта

sudo apt-get update
sudo apt-get install unzip

yes Y | sudo rm -r app
sudo mkdir -m 777 notebooks

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

sudo docker run -it -p 8888:8888 --name jupyter_datascience_instance -v $(pwd)/jupyter_datascience/notebooks:/home/jovyan/work jupyter_datascience:latest
