# Use the official Nginx image as a base
FROM nginx:1.27.0

COPY ./.build/conf.d /etc/nginx/conf.d
COPY ./.build/locations /etc/nginx/locations
COPY ssl/fzmacair /etc/nginx/ssl

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80
EXPOSE 443

# By default, Nginx will start in the foreground so no CMD is needed
