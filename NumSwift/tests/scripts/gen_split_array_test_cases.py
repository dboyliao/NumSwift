#!/usr/bin/env python
import numpy as np
import sys
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-n", "--num", help = "number of splits",
                    dest = "ns", default = 10, type = int)
args = parser.parse_args()
num_of_splits = args.ns

with open("./tests/data/test_split_array.csv") as f:
    s = f.read()
    data = np.array(list(map(float, s.split(","))), dtype = np.float64)

splits = np.array_split(data, num_of_splits)

for i in range(num_of_splits):
    with open("./tests/data/output_split_array_{}.csv".format(i+1), "w") as f:
        f.write(",".join(map(str, splits[i])))
