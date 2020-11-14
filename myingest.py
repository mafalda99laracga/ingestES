import sys
import csv
import json
from pprint import pprint
from elasticsearch import Elasticsearch
es = Elasticsearch(
    ['X.X.X.X'], # master node IP of ES cluster
    port=9200

)

csvFile = open("/src/test.csv",'r')
jsonFile = open("/src/test.json",'w')

fieldnames = ("id","file_name","num")
reader = csv.DictReader( csvFile, fieldnames)
###reader = csv.DictReader( csvFile)

for row in reader:
    json.dump(row, jsonFile)
    jsonFile.write('\n')

#######################################################
# to do the bulk
MyFile = open("/src/test.json",'r').read()
ClearData = MyFile.splitlines(True)
i=0
json_str=""
docs ={}

for line in ClearData:
    line = ''.join(line.split())
    if line != "},":
        json_str = json_str+line
    else:
        docs[i]=json_str+"}"
        json_str=""
        print(docs[i])
        es.index(index='journal', doc_type='_doc', id=i, body=docs[i])
        i=i+1
