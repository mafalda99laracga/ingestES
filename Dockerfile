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
