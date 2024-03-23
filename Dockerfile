FROM ubuntu

RUN apt update && \
    apt upgrade -y && \
    apt install -y nginx && \ 
    rm /var/www/html/index.nginx-debian.html

COPY /Users/immanuelsabwami/Git/WSU/s24cicd-isabwami/website/index.html /var/www/html

CMD systemctl start nginx