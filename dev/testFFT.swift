#!/usr/bin/env swift
import Accelerate

var sigN = 16
var sigf = [Float](count: sigN, repeatedValue: 0.0)
var sigd = [Double](count: sigN, repeatedValue: 0.0)

for i in 0..<sigN {
    sigf[i] = Float(i+1)
    sigd[i] = Double(i+1)
}
print("sigf: \(sigf)")
print("sigd: \(sigd)")

print("=== using vDSP_fft_zipD ===")

// Reusable setup
var N = sigd.count
var log2N = vDSP_Length(floor(log2(Float(N))))
print(log2N)
var radix = FFTRadix(kFFTRadix2)
var setup = vDSP_create_fftsetupD(log2N, radix)
var forward = FFTDirection(kFFTDirection_Forward)

var realp = [Double](sigd)
var imagp = [Double](count:sigd.count, repeatedValue:0.0)
var splitComplex = DSPDoubleSplitComplex(realp:&realp, imagp:&imagp)

vDSP_fft_zipD(setup, &splitComplex, 1, log2N, forward)

for i in 0..<N{
    print(splitComplex.realp[i], splitComplex.imagp[i])
}

vDSP_destroy_fftsetupD(setup)

print("=== using vDSP_fft_zip ===")
var setupf = vDSP_create_fftsetup(log2N, radix)

var realpf = [Float](sigf)
var imagpf = [Float](count: sigf.count, repeatedValue:0.0)
var splitComplexf = DSPSplitComplex(realp: &realpf, imagp: &imagpf)

vDSP_fft_zip(setupf, &splitComplexf, 1, log2N, forward)
vDSP_destroy_fftsetup(setupf)

for i in 0..<N{
    print(splitComplexf.realp[i], splitComplexf.imagp[i])
}


// func getEvenOddArray<T>(array:[T]) -> ([T], [T]){
//     var evenArray = [T]()
//     var oddArray = [T]()

//     for idx in 0..<array.count{
//         if idx % 2 == 0 {
//             evenArray.append(array[idx])
//         } else {
//             oddArray.append(array[idx])
//         }
//     }
//     return (evenArray, oddArray)
// }

// func getComplexArray(array: [Double]) -> [DSPDoubleComplex] {
//     var currentIdx = 0
//     var complexArray = [DSPDoubleComplex]()
//     while currentIdx < array.count {
//         complexArray.append(DSPDoubleComplex(real: array[currentIdx], imag: array[currentIdx+1]))
//         currentIdx += 2
//     }
//     return complexArray
// }

// var complexArray = getComplexArray(sigd)
// var realp = UnsafeMutablePointer<Double>(malloc(8 * sizeof(Double)))
// var imagp = UnsafeMutablePointer<Double>(malloc(8 * sizeof(Double)))
// var complexSig = DSPDoubleSplitComplex(realp: realp, imagp: imagp)

// vDSP_ctozD(&complexArray, 2, &complexSig, 1, 8)
// for i in 0..<8{
//     print(complexSig.realp[i], complexSig.imagp[i])
// }

// var N = Double(sigd.count)
// var log2N = vDSP_Length(floor(log2(N)))
// var radix2 = FFTRadix(kFFTRadix2)
// var forward = FFTDirection(kFFTDirection_Forward)
// var setup = vDSP_create_fftsetupD(log2N, radix2)

// // var realp = [Double](sigd)
// // var imagp = [Double](count:sigd.count, repeatedValue: 0.0)
// // var complexSig = DSPDoubleSplitComplex(realp:realp, imagp: imagp)

// vDSP_fft_zripD(setup, &complexSig, 1, log2N, forward)
// vDSP_destroy_fftsetupD(setup)

// for i in 0..<8 {
//     print(complexSig.realp[i], complexSig.imagp[i])
// }