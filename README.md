# ingestES

# Python Docker image to ingest data to Elasticsearch cluster
Ingest csv data file to Elasticsearch cluster by Python library

## Dockerfile

FROM node:12.13.0-alpine

RUN apk add --no-cache python2 && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools && \
    pip install elasticsearch_loader && \
    rm -r /root/.cache

WORKDIR /src

COPY test.csv /src
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

### docker-build
docker build -t pyingest .

### docker-run
docker run pyingest /bin/sh
