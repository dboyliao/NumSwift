#!/usr/bin/env swift
import Accelerate

// var signal:[Double] = [1, 2, 3, 4]
// var zeros = [Double](count:5, repeatedValue:0)

// var coef = fft(signal, imagp:zeros)

// var one = 1.0
// var output = [Double](count:coef.realp.count, repeatedValue:0.0)
// print(coef.realp)

// vDSP_vsaddD(&(coef.realp), 1, &one, &output, 1, vDSP_Length(output.count))
// print(output)

var temp = [Double](count:10, repeatedValue:0.0)
var value = 1.0
vDSP_vfillD(&value, &(temp[1]), 1, vDSP_Length(9))
print(temp)