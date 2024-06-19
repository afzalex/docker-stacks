# Use the official Nginx image as a base
FROM nginx:latest

RUN apt update && \
    apt install -y luarocks && \
    luarocks install lua-resty-openidc

COPY conf.d /etc/nginx/conf.d
COPY ssl/fzmacair /etc/nginx/ssl

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80
EXPOSE 443

# By default, Nginx will start in the foreground so no CMD is needed
