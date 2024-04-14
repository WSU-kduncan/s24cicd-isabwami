#! /bin/bash

# kill the old container process
docker stop project5_nginx
docker remove project5_nginx

# pull fresh image
docker pull isabwami/sabwami-project4:latest

# run new container
docker run -d -p 90:80 --name project5_nginx --restart always isabwami/sabwami-project4:latest
