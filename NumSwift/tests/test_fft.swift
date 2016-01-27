import NumSwift

let N: Int = 16

// Tests for FFT (float signal)
colorPrint("======== Test on FFT Float =======", color:"yellow")

var sigf = [Float](count:N, repeatedValue:0.0)
let zerosf = [Float](count:N, repeatedValue:0.0)

for i in 0..<N {
    sigf[i] = Float(i+1)
}

func testFFTRealpFloat() -> [Float] {
    let coeff = fft(sigf, imagp:zerosf)
    let coeff_realp = coeff.realp
    return coeff_realp
}

func testFFTImagpFloat() -> [Float] {
    let (_, coeff_imagp) = fft(sigf, imagp:zerosf)
    return coeff_imagp
}

// These answers are derieved from numpy.fft.fft 
let answerCoefFloatRealp:[Float] = [136, -8, -8, -8, -8, -8, -8, -8, 
                                    -8, -8, -8, -8, -8, -8, -8, -8]
let answerCoefFloatImagp:[Float] = [0, 40.218715, 19.313708, 11.972846,
                                    8, 5.345429, 3.313708, 1.591298,
                                    0, -1.591298, -3.313708, -5.345429,
                                    -8, -11.972846, -19.313708, -40.218715]

testEqualInTol("FFT Float Real Part", test:testFFTRealpFloat, expect:answerCoefFloatRealp, tol:1e-5)
testEqualInTol("FFT Float Imag Part", test:testFFTImagpFloat, expect:answerCoefFloatImagp, tol:1e-5)

// Tests for inverse FFT (float signal)
colorPrint("======== Test on Inverse FFT Float =======", color:"yellow")

let (coeff_realp, coeff_imagp) = fft(sigf, imagp:zerosf)

func testInverseFFTRealpFloat() -> [Float] {

    let (sigf_realp, _) = ifft(coeff_realp, imagp:coeff_imagp)
    return sigf_realp

}

func testInverseFFTImagpFloat() -> [Float] {

    let (_, sigf_imagp) = ifft(coeff_realp, imagp:coeff_imagp)
    return sigf_imagp
    
}

testEqualInTol("Test iFFT Float Realp", test:testInverseFFTRealpFloat, expect:sigf, tol:1e-6)
testEqualInTol("Test iFFT Float Imagp", test:testInverseFFTImagpFloat, expect:zerosf, tol:1e-6)


// Tests for FFT (Double Signal)
colorPrint("======== Test on FFT Double =======", color:"yellow")

var sigd = [Double](count:N, repeatedValue:0.0)
let zerosd = [Double](count:N, repeatedValue:0.0)

for i in 0..<N {
    sigd[i] = Double(i+1)
}

func testFFTRealpDouble() -> [Double] {

    let (coefd_realp, _) = fft(sigd, imagp:zerosd)
    return coefd_realp

}

func testFFTImagpDouble() -> [Double] {

    let (_, coefd_imagp) = fft(sigd, imagp:zerosd)
    return coefd_imagp

}

let answerCoefDoubleRealp:[Double] = [136, -8, -8, -8, -8, -8, -8, -8, 
                                      -8, -8, -8, -8, -8, -8, -8, -8]
let answerCoefDoubleImagp:[Double] = [0, 40.218715937, 19.313708499, 11.9728461013,
                                      8, 5.34542910335, 3.31370849898, 1.59129893904,
                                      0, -1.59129893904, -3.31370849898, -5.34542910335,
                                      -8, -11.9728461013, -19.313708499, -40.218715937]

testEqualInTol("Test FFT Double Realp", test:testFFTRealpDouble, expect:answerCoefDoubleRealp, tol:1e-9)
testEqualInTol("Test FFT Double Imagp", test:testFFTImagpDouble, expect:answerCoefDoubleImagp, tol:1e-9)

// Tests for inverse FFT (Double signal)
colorPrint("======== Test on Inverse FFT Double =======", color:"yellow")

let (coefd_realp, coefd_imagp) = fft(sigd, imagp:zerosd)

func testInverseFFTRealpDouble() -> [Double] {

    let (sigd_realp, _) = ifft(coefd_realp, imagp:coefd_imagp)
    return sigd_realp

}

func testInverseFFTImagpDouble() -> [Double] {

    let (_, sigd_imagp) = ifft(coefd_realp, imagp:coefd_imagp)
    return sigd_imagp
    
}

testEqualInTol("Test iFFT Double Realp", test:testInverseFFTRealpDouble, expect:sigd, tol:1e-15)
testEqualInTol("Test iFFT Double Imagp", test:testInverseFFTImagpDouble, expect:zerosd, tol:1e-15)
