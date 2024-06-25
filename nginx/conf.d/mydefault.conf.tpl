server {
    listen 80;
    listen [::]:80;
    server_name ${FZNGINX_HOST} 192.168.29.114;
    return 301 https://$host$request_uri;  # Redirect all HTTP traffic to HTTPS
}

server {
	listen 443 ssl;

	server_name ${FZNGINX_HOST} 192.168.29.114 ;

    ssl_certificate /etc/nginx/ssl/${FZNGINX_HOST}.crt;
    ssl_certificate_key /etc/nginx/ssl/${FZNGINX_HOST}.key;

   	ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;


    access_log  /var/log/nginx/${FZNGINX_SITE}.log;
    error_log  /var/log/nginx/${FZNGINX_SITE}.log debug;


    include locations/jupyterlab.conf;
    include locations/keycloak.conf;
}
