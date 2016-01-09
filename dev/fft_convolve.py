#!/usr/bin/env python2
import numpy as np
import argparse

def main(args):
    N = args.N
    M = args.M

    if N < M:
        N, M = M, N

    convN = N + M -1
    a = np.array([i for i in range(1, N+1)])
    b = np.array([i for i in range(1, M+1)])
    print(np.convolve(a, b))

    a = np.hstack((a, np.zeros(convN - N)))
    b = np.hstack((b, np.zeros(convN - M)))

    coef1 = np.fft.fft(a)
    coef2 = np.fft.fft(b)

    coef_p = coef1 * coef2

    print(np.fft.ifft(coef_p))

if __name__ == "__main__":
    parsor = argparse.ArgumentParser()
    parsor.add_argument("-N", type = int, dest = "N")
    parsor.add_argument("-M", type = int, dest = "M")

    args = parsor.parse_args()
    main(args)
