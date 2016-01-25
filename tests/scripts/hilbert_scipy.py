#!/usr/bin/env python3
import time
import sys
import numpy as np
from scipy.signal import hilbert

N = int(sys.argv[1])
repeat = int(sys.argv[2])
sig = np.array([i for i in range(1, N+1)])

def run_hilbert():
    start = time.time()
    hilbert(sig)
    end = time.time()
    return end - start

if __name__ == "__main__":

    r = []
    for _ in range(repeat):
        r.append(run_hilbert())

    print("input size: {}".format(N))
    print("best of {}: {:.6f} secs".format(repeat, min(r)))
    print("\033[1;35mmean time:{}\033[0m".format(np.mean(r)))
    print("\033[1;35mstd: {}\033[0m".format(np.std(r)))