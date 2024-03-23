FROM ubuntu

RUN apt update && \
    apt upgrade -y && \
    apt install -y \ 
    nginx && \
    rm /var/www/html/index.nginx-debian.html

COPY ./website/index.html /var/www/html/

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80