#!/usr/bin/env python3
import time
import sys
import numpy as np
from scipy.signal import fftconvolve

M = int(sys.argv[1])
N = int(sys.argv[2])
repeat = int(sys.argv[3])
x = np.array([i for i in range(1, M+1)])
y = np.array([i for i in range(1, N+1)])

def run_convolve():
    start = time.time()
    fftconvolve(x, y)
    end = time.time()
    return end - start

if __name__ == "__main__":

    r = []
    for _ in range(repeat):
        r.append(run_convolve())

    print("input size: \nx:{}\ny:{}".format(M, N))
    print("\033[1;36mbest of {}: {:.6f} secs\033[0m".format(repeat, min(r)))
    print("\033[1;35mmean time:{}\033[0m".format(np.mean(r)))
    print("\033[1;35mstd: {}\033[0m".format(np.std(r)))