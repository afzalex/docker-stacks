FROM python:3
ENV ACCESS_TOKEN_KEY 'accesstoken'
ENV ACCESS_TOKEN_VALUE 'myaccesstokenvalue'
EXPOSE 8000
COPY ./app /app
COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
COPY start.sh start.sh
ENTRYPOINT ["/bin/bash", "start.sh"]