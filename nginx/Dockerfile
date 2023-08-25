# Use the official Nginx image as a base
FROM nginx:latest

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Copy local video files to the container
COPY ./videos .

# Expose port 80 for the Nginx server
EXPOSE 80

# By default, Nginx will start in the foreground so no CMD is needed
