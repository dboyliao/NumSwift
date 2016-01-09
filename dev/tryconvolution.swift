#!/usr/bin/env swift
import Accelerate

var N = 6
var M = 3
var convN = N + M - 1
// print(N, M, convN)

var xf = [Float](count:N, repeatedValue:0.0)
var yf = [Float](count:M, repeatedValue:0.0)

for i in 0..<N {
    xf[i] = Float(i+1)
}
for i in 0..<M {
    yf[i] = Float(i+1)
}

var outputf = [Float](count:convN, repeatedValue:-1.0)

// padding zero
xf = [Float](count:convN-N, repeatedValue:0.0) + xf

var ptr_xf = UnsafePointer<Float>(xf)
var ptr_yf = UnsafePointer<Float>(yf).advancedBy(yf.count-1)
var ptr_outputf = UnsafeMutablePointer<Float>(outputf)
let strideOne = vDSP_Stride(1)
let strideNegOne = vDSP_Stride(-1)

vDSP_conv(ptr_xf, strideOne, ptr_yf, strideNegOne, ptr_outputf, strideOne, vDSP_Length(convN), vDSP_Length(M))
print("[Float]: \(outputf)")

// sleep(3)

var xd = [Double](count:N, repeatedValue:0.0)
var yd = [Double](count:M, repeatedValue:0.0)
for i in 0..<N {
    xd[i] = Double(i+1)
}
for i in 0..<M {
    yd[i] = Double(i+1)
}

var outputd = [Double](count:convN, repeatedValue:0.0)

// padding zero
xd = [Double](count:convN - N, repeatedValue:0) + xd

var ptr_xd = UnsafePointer<Double>(xd)
var ptr_yd = UnsafePointer<Double>(yd).advancedBy(yd.count-1)
var ptr_outputd = UnsafeMutablePointer<Double>(outputd)

vDSP_convD(ptr_xd, 1, ptr_yd, -1, ptr_outputd, 1, 
           vDSP_Length(convN), vDSP_Length(M))
print("[Double]: \(outputd)")
// sleep(3)