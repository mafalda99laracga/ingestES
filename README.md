# ingestES

# Python Docker image to ingest data to Elasticsearch cluster
Ingest csv data file to Elasticsearch cluster by Python script

## Dockerfile

FROM gliderlabs/alpine:3.3

RUN apk add --update-cache \
    py-pip \
  && pip install elasticsearch \
  && rm -rf /var/cache/apk/*

WORKDIR /src

COPY myingest.py /src
COPY test.csv /src
COPY test.json /src
CMD ["python", "/src/myingest.py"]

### docker-build
docker build -t pyingest .

### docker-run
docker run pyingest python /src/myingest.py
