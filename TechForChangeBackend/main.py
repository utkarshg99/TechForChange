import os
import shutil
import json
from pymongo import MongoClient

uri='mongodb://127.0.0.1:27017/'
client = MongoClient(uri)
db=client.tfc

def execute_file_transform(entry):
    fnamew_oext=entry["fname"]
    fnamew_oext=fnamew_oext[:len(fnamew_oext)-4]
    command="ffmpeg -i"+entry["dest"]+" ./unprocessed/"+fnamew_oext+".wav"
    os.system(command)
    command="python3 annotation.py "+" ./unprocessed/"+fnamew_oext
    os.system(command)

def runner():
    while True:
        entry = db.entries.find_one({'status':False})
        if(entry == None):
            continue
        print(entry)
        execute_file_transform(entry)
        fnamew_oext=entry["fname"]
        fnamew_oext=fnamew_oext[:len(fnamew_oext)-4]
        command = "python3 core.py "+fnamew_oext+" "+entry["uidx"]
        os.system(command)
        break
try:
    runner()
except:
    runner()