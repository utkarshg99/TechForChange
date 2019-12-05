import os
import shutil
import json
from pymongo import MongoClient

print("PostProcessing")
uri='mongodb://127.0.0.1:27017/'
client = MongoClient(uri)
db=client.tfc

def runner():
    while True:
        entry = db.entries.find_one({'status':True})
        if(entry == None):
            continue
        src = entry['dest']
        dest = './processed/'
        idx = entry['_id']
        shutil.move(src, dest)
        delete_query = { "_id": idx }
        db.entries.delete_one(delete_query)
try:
    runner()
except:
    runner()