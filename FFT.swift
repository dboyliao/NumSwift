import Accelerate

func fft(x:[Double]) -> DSPDoubleSplitComplex {

    let N = Float(x.count)
    let log2N = vDSP_Length(ceil(log2(N)))
    let radix = FFTRadix(kFFTRadix2)
    let setup = vDSP_create_fftsetupD(log2N, radix)
    print("setup", setup)
    print(log2N)

    var realp = [Double](x)
    var imagp = [Double](count:x.count, repeatedValue:0.0)
    var fftCoef = DSPDoubleSplitComplex(realp:&realp, imagp:&imagp)
    let forward = FFTDirection(kFFTDirection_Forward)

    vDSP_fft_zipD(setup, &fftCoef, 1, log2N, forward)

    vDSP_destroy_fftsetupD(setup)

    return fftCoef
}

func fft(x:[Float]) -> DSPSplitComplex {

    let N = Float(x.count)
    let log2N = vDSP_Length(ceil(log2(N)))
    let radix = FFTRadix(kFFTRadix2)
    let setup = vDSP_create_fftsetup(log2N, radix)
    print("setup", setup)
    print(log2N)

    var realp = [Float](x)
    var imagp = [Float](count:x.count, repeatedValue:0.0)
    var fftCoef = DSPSplitComplex(realp:&realp, imagp:&imagp)
    let forward = FFTDirection(kFFTDirection_Forward)

    vDSP_fft_zip(setup, &fftCoef, 1, log2N, forward)
    
    vDSP_destroy_fftsetup(setup)

    return fftCoef
}

// func fft_r(x:[Double], radix: FFTRadix = FFTRadix(kFFTRadix2)) -> [DSPDoubleComplex]{
//     /*
//       Real Fast Fourier Transform: use vDSP_fft_zrip from vDSP in Accelerate framework
//       It is more memory efficient for real signal.
//     */

//     // wrap up the complex signal
//     var (realp, imagp) = getEvenOddArray(x)
//     var complexSig = DSPDoubleSplitComplex(realp: &realp, imagp: &imagp)

//     // setup the fftsetup
//     let N = Double(x.count)
//     let log2N = vDSP_Length(floor(log2(N)))
//     let setup = vDSP_create_fftsetup(log2N, radix)

//     // do th fft
//     vDSP_fft_zrip(setup, &complexSig, 1, log2N, FFTDirection(kFFTDirection_Forward))

//     vDSP_destroy_fftsetupD(setup)
// }

// func fft_r(x:[Float], radix: FFTRadix = FFTRadix(kFFTRadix2)) -> [DSPComplex]{

// }

// func ifft_r(x:DSPDoubleSplitComplex, radix: FFTRadix = FFTRadix(kFFTRadix2)) -> [Double]{

// }

// func ifft_r(x:DSPSplitComplex, radix: FFTRadix = FFTRadix(kFFTRadix2)) -> [Double] {

// }