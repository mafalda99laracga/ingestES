#!/bin/sh

#python /src/myingest.py

# /src/test.json transform
##touch /src/data.json

##aux='{"_index":"journal","_type":"doc","_source":'
##cat /src/test.json | while read line
##do
##echo $aux$line"}"
##done >> /src/data.json

# type mapping or data
#elasticdump \
#--bulk=true \
#--input="/src/data.json" \
#--output="http://X.X.X.X:9200/journal" \
#--debug \
#--limit=10000 \
#--headers='{"Content-Type": "application/x-ndjson"}' \
#--type=data

#elasticsearch_loader \
#    --es-host="http://X.X.X.X:9200" \
#    --index="journal" \
#    --type="test" \
#    json --json-lines /src/test.json

elasticsearch_loader --es-host="http://X.X.X.X:9200" --index journal --type text csv /src/test.csv
