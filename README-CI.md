# Project 4
## CI Project Overview
- The goal of this project is to containerize an application, which in this case is going to be a website running on nginx, and to automate pipeline using GitHub actions. This allows us to gain the benefits of portable applications that containers offer. I'll be using DockerHub, Docker Desktop (except not on the desktop but in the terminal), GitHub, and nginx. 

## Run Project Locally
- Since I am using MacOS, I actually just installed Docker Desktop from Dockers website, and can now use it in the terminal as long as the application is running in the background.
- To build the image from the Dockerfile, I used `docker build -t nginx_ubuntu:latest .`
- To run the container I used `docker run -it --name project4_nginx -p 80:80 nginx_ubuntu:latest`
- To view the project running in the container I serach http://localhost in the address bar of a browser 
