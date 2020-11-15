FROM node:12.13.0-alpine

# PYTHON and py libs

RUN apk add --no-cache python2 && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools && \
#    pip install elasticsearch && \
    pip install elasticsearch_loader && \
    rm -r /root/.cache

# npm lib
#RUN npm i -g elasticdump@6.15.5

# check version of npm es lib
#RUN elasticdump --version

WORKDIR /src

#COPY myingest.py /src
COPY test.csv /src
#COPY test.json /src

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

#CMD ["python", "/src/myingest.py"]
