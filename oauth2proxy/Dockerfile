FROM quay.io/oauth2-proxy/oauth2-proxy:v7.6.0-alpine

EXPOSE 4180

RUN apk add --no-cache socat curl

# Ensure entrypoint file is executable
COPY ./entrypoint /usr/local/entrypoint

ENTRYPOINT ["/usr/local/entrypoint"]

