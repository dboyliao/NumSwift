#!/usr/bin/env swift
import Accelerate

// var x = [DSPComplex(real:1, imag:0), 
//          DSPComplex(real:2, imag:0), 
//          DSPComplex(real:3, imag:0), 
//          DSPComplex(real:4, imag:0),
//          DSPComplex(real:5, imag:0),
//          DSPComplex(real:6, imag:0)]
var x:[Float] = [1, 2, 3, 4, 5, 6]

var realp = [Float]([1, 2, 3])
var imagp = [Float]([4, 5, 6])
var z = DSPSplitComplex(realp: &realp, imagp: &imagp)

// vDSP_ctoz(x, 2, &z, 1, vDSP_Length(6))

for i in 0..<12 {
    print(z.realp[i])
}