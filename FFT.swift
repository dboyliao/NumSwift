import Accelerate

func fft(realp:[Double], imagp: [Double]) -> ([Double], [Double]) {

    /*
    Complex-to-Complex Fast Fourier Transform.
    */

    // Note that we only use radix-2 fft. Which means it 
    // may process only partial of the input depending on
    // the # of your samples is of power of 2 or not.

    let log2N = vDSP_Length(log2f(Float(realp.count)))
    let fftN = Int(1 << log2N)

    // buffers.
    let inputRealp = [Double](realp[0..<fftN])
    let inputImagp = [Double](imagp[0..<fftN])
    let fftCoefRealp = [Double](count: fftN, repeatedValue:0.0)
    let fftCoefImagp = [Double](count: fftN, repeatedValue:0.0)
    let ptrCoefReal = UnsafeMutablePointer<Double>(fftCoefRealp)
    let ptrCoefImag = UnsafeMutablePointer<Double>(fftCoefImagp)

    // setup DFT and execute.
    let setup = vDSP_DFT_zop_CreateSetupD(nil, vDSP_Length(fftN), vDSP_DFT_Direction.FORWARD)
    vDSP_DFT_ExecuteD(setup, inputRealp, inputImagp, ptrCoefReal, ptrCoefImag)

    // destroy setup.
    vDSP_DFT_DestroySetupD(setup)

    return (realp: fftCoefRealp, imagp: fftCoefImagp)
}

func fft(realp:[Float], imagp:[Float]) -> ([Float], [Float]){

    /*
    Complex-to-Complex Fast Fourier Transform.

    Basically the same as fft([Double]) except calling different 
    fundamental APIs of Accelerate.
    */

    let log2N = vDSP_Length(log2f(Float(realp.count)))
    let fftN = Int(1 << log2N)

    // buffers.
    let inputRealp = [Float](realp[0..<fftN])
    let inputImagp = [Float](imagp[0..<fftN])
    let fftCoefRealp = [Float](count: fftN, repeatedValue:0.0)
    let fftCoefImagp = [Float](count: fftN, repeatedValue:0.0)
    let ptrCoefReal = UnsafeMutablePointer<Float>(fftCoefRealp)
    let ptrCoefImag = UnsafeMutablePointer<Float>(fftCoefImagp)

    // setup DFT and execute.
    let setup = vDSP_DFT_zop_CreateSetup(nil, vDSP_Length(fftN), vDSP_DFT_Direction.FORWARD)
    vDSP_DFT_Execute(setup, inputRealp, inputImagp, ptrCoefReal, ptrCoefImag)

    // destroy setup.
    vDSP_DFT_DestroySetup(setup)

    return (realp: fftCoefRealp, imagp: fftCoefImagp)

}

// TODOs:
func ifft(realp:[Double], imagp:[Double]) -> ([Double], [Double]){
    /*
    Complex-to-Complex Inverse Fast Fourier Transform.
    */

    // Note that we only use radix-2 fft. Which means it 
    // may process only partial of the input depending on
    // the # of your samples is of power of 2 or not.

    let log2N = vDSP_Length(log2f(Float(realp.count)))
    let fftN = Int(1 << log2N)

    // buffers.
    let coefRealp = [Double](realp[0..<fftN])
    let coefImagp = [Double](imagp[0..<fftN])
    let outputRealp = [Double](count: fftN, repeatedValue:0.0)
    let outputImagp = [Double](count: fftN, repeatedValue:0.0)
    let ptrOutputReal = UnsafeMutablePointer<Double>(outputRealp)
    let ptrOutputImag = UnsafeMutablePointer<Double>(outputImagp)

    // setup DFT and execute.
    let setup = vDSP_DFT_zop_CreateSetupD(nil, vDSP_Length(fftN), vDSP_DFT_Direction.INVERSE)
    vDSP_DFT_ExecuteD(setup, coefRealp, coefImagp, ptrOutputReal, ptrOutputImag)

    // normalization of ifft
    var scale = Double(fftN)
    let normalizedOutputRealp = [Double](count: fftN, repeatedValue:0.0)
    let normalizedOutputImagp = [Double](count: fftN, repeatedValue:0.0)
    let ptrNormalizeOutputRealp = UnsafeMutablePointer<Double>(normalizedOutputRealp)
    let ptrNormalizeOutputImagp = UnsafeMutablePointer<Double>(normalizedOutputImagp)
    vDSP_vsdivD(outputRealp, 1, &scale, ptrNormalizeOutputRealp, 1, vDSP_Length(fftN))
    vDSP_vsdivD(outputImagp, 1, &scale, ptrNormalizeOutputImagp, 1, vDSP_Length(fftN))

    // destroy setup.
    vDSP_DFT_DestroySetupD(setup)

    return (realp: normalizedOutputRealp, imagp:normalizedOutputImagp)
}

func ifft(realp:[Float], imagp:[Float]) -> ([Float], [Float]){
    /*
    Complex-to-Complex Inverse Fast Fourier Transform.
    */

    // Note that we only use radix-2 fft. Which means it 
    // may process only partial of the input depending on
    // the # of your samples is of power of 2 or not.

    let log2N = vDSP_Length(log2f(Float(realp.count)))
    let fftN = Int(1 << log2N)

    // buffers.
    let coefRealp = [Float](realp[0..<fftN])
    let coefImagp = [Float](imagp[0..<fftN])
    let outputRealp = [Float](count: fftN, repeatedValue:0.0)
    let outputImagp = [Float](count: fftN, repeatedValue:0.0)
    let ptrOutputReal = UnsafeMutablePointer<Float>(outputRealp)
    let ptrOutputImag = UnsafeMutablePointer<Float>(outputImagp)

    // setup DFT and execute.
    let setup = vDSP_DFT_zop_CreateSetup(nil, vDSP_Length(fftN), vDSP_DFT_Direction.INVERSE)
    vDSP_DFT_Execute(setup, coefRealp, coefImagp, ptrOutputReal, ptrOutputImag)

    // normalization of ifft
    var scale = Float(fftN)
    print(scale)
    let normalizedOutputRealp = [Float](count: fftN, repeatedValue:0.0)
    let normalizedOutputImagp = [Float](count: fftN, repeatedValue:0.0)
    let ptrNormalizedOutputRealp = UnsafeMutablePointer<Float>(normalizedOutputRealp)
    let ptrNormalizedOutputImagp = UnsafeMutablePointer<Float>(normalizedOutputImagp)
    vDSP_vsdiv(outputRealp, 1, &scale, ptrNormalizedOutputRealp, 1, vDSP_Length(fftN))
    vDSP_vsdiv(outputImagp, 1, &scale, ptrNormalizedOutputImagp, 1, vDSP_Length(fftN))

    // destroy setup.
    vDSP_DFT_DestroySetup(setup)

    return (realp: normalizedOutputRealp, imagp:normalizedOutputImagp)
}