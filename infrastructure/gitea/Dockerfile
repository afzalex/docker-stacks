FROM gitea/gitea:1.13.6
EXPOSE 7001/tcp
COPY init/data /tmp/data
COPY modified-entrypoint.sh /entrypoint.sh
# CMD "echo Hello World!"
ENTRYPOINT [ "/entrypoint.sh" ]