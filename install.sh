#!/bin/bash

#Directorios
sudo mkdir -p /opt/docker-compose-files
sudo mkdir -p /var/mysql-docker

#Archivos
sudo cp ./docker-compose-init /usr/local/bin/
sudo cp Dockerfile /opt/docker-compose-files/
sudo cp docker-compose.yml  /opt/docker-compose-files/
