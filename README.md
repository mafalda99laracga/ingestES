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

### Elasticsearch configuration for large data ingest
curl -H 'Content-Type: application/json' -X PUT 'http://localhost:9200/journal/_settings?master_timeout=300s&timeout=5m' -d \
'{"index" : {"number_of_replicas" : 2} }'

### Elasticsearch free up disk space

curl -XPUT -H "Content-Type: application/json" http://localhost:9200/_all/_settings -d '{"index.blocks.read_only_allow_delete": null}'

curl -XPUT -H "Content-Type: application/json" http://localhost:9200/_cluster/settings -d '{ "transient": { "cluster.routing.allocation.disk.threshold_enabled": false } }'

### Elasticsearch updating the low watermark to at least 2 gigabytes free, a high watermark of at least 1 gigabytes free, and a flood stage watermark of 1 gigabytes free, and updating the information about the cluster every minute

curl -X PUT "http://localhost:9200/_cluster/settings?pretty" -H 'Content-Type: application/json' -d' { "transient": { "cluster.routing.allocation.disk.watermark.low": "2gb", "cluster.routing.allocation.disk.watermark.high": "1gb", "cluster.routing.allocation.disk.watermark.flood_stage": "1gb", "cluster.info.update.interval": "1m"}}'
