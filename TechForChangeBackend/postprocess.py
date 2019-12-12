import os
import shutil
import json
from pymongo import MongoClient

uri='mongodb://127.0.0.1:27017/'
client = MongoClient(uri)
db=client.tfc

def runner():
    while True:
        entry = db.entries.find_one({'status':True, 'postproc': False})
        if(entry == None):
            continue
        src = entry['dest']
        dest = './processed/'
        shutil.move(src, dest)
        db.entries.update_one({'fname': entry['fname']},
        {'$set': {
            "postproc":True
        }
        }, upsert=False)
try:
    runner()
except:
    runner()