#!/usr/bin/env python2
#-*- coding: utf-8 -*-
import sys
import subprocess

def main():
    cmd = sys.argv[1]
    repeat_times = int(sys.argv[2])

    for _ in range(repeat_times):
        subprocess.call(cmd, shell = True)

if __name__ == "__main__":
    main()
