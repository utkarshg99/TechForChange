from pydub import AudioSegment 
import speech_recognition as sr
import sys
inpx = sys.argv[1]
inpath = inpx+".wav"
audio = AudioSegment.from_wav(inpath) 
n = len(audio)
counter = 1
outpath=inpx+".txt"
fh = open(outpath, "w+")
interval = 2 * 1000
overlap = 0
start = 0
end = 0
flag = 0
for i in range(0, 2 * n, interval):
    if i == 0: 
        start = 0
        end = interval
    else: 
        start = end - overlap 
        end = start + interval
    if end >= n: 
        end = n 
        flag = 1
    # print(start/1000,"",end/1000)
    initial=str(start/1000)
    final=str(end/1000)
    det=initial+"\t"+final+"\n"
    fh.write(det)
    counter = counter + 1
    if flag == 1: 
        fh.close() 
        break
