import librosa  
import sys
var = 4000
filename = sys.argv[1]
inpath = filename +".wav"
y, s = librosa.load(inpath, var)
import matplotlib.pyplot as plt
import numpy as np
from scipy.signal import hilbert, chirp

y1=np.array(y)
Fs = s
x =np.arange(len(y))
ty = hilbert(y1)
y2 = np.abs(ty)
def getEnvel (inputSignal):
    absoluteSignal = []
    for sample in inputSignal:
        absoluteSignal.append (abs (sample))
    intervalLength = 500 
    outputSignal = []
    for baseIndex in range (intervalLength, len (absoluteSignal)):
        maximum = np.mean(absoluteSignal[baseIndex-intervalLength:baseIndex])
        outputSignal.append (maximum)
    # print(maximum.shape)
    return outputSignal

qw = getEnvel(y1)
qw=np.array(qw)

xt = x[:len(y)-500]
from matplotlib import pyplot as plt
L = qw
L = np.round(L, 1)
L -= np.mean(L)
fft = np.fft.rfft(L, norm="ortho")

def abs2(x):
    return x.real**2 + x.imag**2

selfconvol=np.fft.irfft(abs2(fft), norm="ortho")
selfconvol=selfconvol/selfconvol[0]


# print(len(L)//4)
def peakdetect(y_axis, x_axis = None, lookahead = 500, delta = 0):
    maxtab = []
    mintab = []
    dump = []
    length = len(y_axis)
    if x_axis is None:
        x_axis = range(length)
    if length != len(x_axis):
        raise ValueError("Input vectors y_axis and x_axis must have same length")
    if lookahead < 1:
        raise ValueError("Lookahead must be above '1' in value")
    if not (np.isscalar(delta) and delta >= 0):
        raise ValueError("delta must be a positive number")
    y_axis = np.asarray(y_axis)
    mn, mx = np.Inf, -np.Inf
    for index, (x, y) in enumerate(zip(x_axis[:-lookahead], y_axis[:-lookahead])):
        if y > mx:
            mx = y
            mxpos = x
        if y < mn:
            mn = y
            mnpos = x
        if y < mx-delta and mx != np.Inf:
            if y_axis[index:index+lookahead].max() < mx:
                maxtab.append((mxpos, mx))
                dump.append(True)
                mx = np.Inf
                mn = np.Inf
        if y > mn+delta and mn != -np.Inf:
            if y_axis[index:index+lookahead].min() > mn:
                mintab.append((mnpos, mn))
                dump.append(False)
                mn = -np.Inf
                mx = -np.Inf
    try:
        if dump[0]:
            maxtab.pop(0)
        else:
            mintab.pop(0)
        del dump
    except IndexError:
        pass
    return maxtab, mintab
def peakdetect_zero_crossing(y_axis, x_axis = None, window = 49):
    if x_axis is None:
        x_axis = range(len(y_axis))
    length = len(y_axis)
    if length != len(x_axis):
        raise ValueError('Input vectors y_axis and x_axis must have same length')
    y_axis = np.asarray(y_axis)
    zero_indices = zero_crossings(y_axis, window = window)
    period_lengths = np.diff(zero_indices)
    bins = [y_axis[indice:indice+diff] for indice, diff in 
        zip(zero_indices, period_lengths)]
    even_bins = bins[::2]
    odd_bins = bins[1::2]
    if even_bins[0].max() > abs(even_bins[0].min()):
        hi_peaks = [bin.max() for bin in even_bins]
        lo_peaks = [bin.min() for bin in odd_bins]
    else:
        hi_peaks = [bin.max() for bin in odd_bins]
        lo_peaks = [bin.min() for bin in even_bins]
    hi_peaks_x = [x_axis[np.where(y_axis==peak)[0]] for peak in hi_peaks]
    lo_peaks_x = [x_axis[np.where(y_axis==peak)[0]] for peak in lo_peaks]
    maxtab = [(x,y) for x,y in zip(hi_peaks, hi_peaks_x)]
    mintab = [(x,y) for x,y in zip(lo_peaks, lo_peaks_x)]
    return maxtab, mintab

def smooth(x,window_len=11,window='hanning'):
    if x.ndim != 1:
        raise ValueError("smooth only accepts 1 dimension arrays.")
    if x.size < window_len:
        raise ValueError("Input vector needs to be bigger than window size.")
    if window_len<3:
        return x
    if not window in ['flat', 'hanning', 'hamming', 'bartlett', 'blackman']:
        raise ValueError("Window is on of 'flat', 'hanning', 'hamming', 'bartlett', 'blackman'")
    s=np.r_[x[window_len-1:0:-1],x,x[-1:-window_len:-1]]
    if window == 'flat':
        w=np.ones(window_len,'d')
    else:
        w=eval('np.'+window+'(window_len)')
    y=np.convolve(w/w.sum(),s,mode='valid')
    return y

def zero_crossings(y_axis, x_axis = None, window = 49):
    length = len(y_axis)
    if x_axis == None:
        x_axis = range(length)
    x_axis = np.asarray(x_axis)
    y_axis = smooth(y_axis, window)[:length]
    zero_crossings = np.where(np.diff(np.sign(y_axis)))[0]
    times = [x_axis[indice] for indice in zero_crossings]
    diff = np.diff(times)
    if diff.std() / diff.mean() > 0.1:
        raise ValueError("smoothing window too small, false zero-crossings found")
    return times

if __name__=="__main__":
    import pylab
    from math import pi
    _max, _min = peakdetect(qw,xt,1000)
    xm = [p[0] for p in _max]
    ym = [p[1] for p in _max]
    xn = [p[0] for p in _min]
    yn = [p[1] for p in _min]

outpath= filename +".txt"
fh = open(outpath, "w+")
n=len(xn)
for i in range(0,n-1):
    NUM1=round(xn[i]/Fs,2)
    NUM2=round(xn[i+1]/Fs,2)
    det=str(NUM1) + "\t" + str(NUM2)+"\n"
    fh.write(det)
fh.close()
