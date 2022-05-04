#FROM alpine:3.14
#
#EXPOSE 80
#COPY './scratchapp' '/var/lib/scratchapp'
#RUN apk add nginx
#RUN apk add curl
#RUN touch /var/log/nginx/error.log
## ENTRYPOINT ["tail", "-f", "/var/log/nginx/error.log"]
#ENTRYPOINT ["/bin/sh", "/var/lib/scratchapp/starter.sh"]
#



FROM openresty/openresty:alpine-fat

RUN mkdir /var/log/nginx
RUN touch /var/log/nginx/error.log

RUN apk add --no-cache openssl-dev
RUN apk add --no-cache git
RUN apk add --no-cache gcc
RUN luarocks install lua-resty-openidc
COPY './scratchapp' '/var/lib/scratchapp'
ENTRYPOINT ["/bin/sh", "/var/lib/scratchapp/starter.sh"]
#ENTRYPOINT ["/usr/local/openresty/nginx/sbin/nginx", "-g", "daemon off;"]
EXPOSE 80