import Accelerate

func fft(realp:[Double], imagp: [Double]) -> (realp:[Double], imagp:[Double]) {

    /*
    Complex-to-Complex Fast Fourier Transform.
    */

    // Note that we only use radix-2 fft. Which means it 
    // may process only partial of the input depending on
    // the # of your samples is of power of 2 or not.

    let log2N = vDSP_Length(log2f(Float(realp.count)))
    let fftN = Int(1 << log2N)

    // buffers.
    var inputRealp = [Double](realp[0..<fftN])
    var inputImagp = [Double](imagp[0..<fftN])
    var fftCoefRealp = [Double](count: fftN, repeatedValue:0.0)
    var fftCoefImagp = [Double](count: fftN, repeatedValue:0.0)

    // setup DFT and execute.
    let setup = vDSP_DFT_zop_CreateSetupD(nil, vDSP_Length(fftN), vDSP_DFT_Direction.FORWARD)
    vDSP_DFT_ExecuteD(setup, &inputRealp, &inputImagp, &fftCoefRealp, &fftCoefImagp)

    // destroy setup.
    vDSP_DFT_DestroySetupD(setup)

    return (fftCoefRealp, fftCoefImagp)
}

func fft(realp:[Float], imagp:[Float]) -> (realp:[Float], imagp:[Float]){

    /*
    Complex-to-Complex Fast Fourier Transform.

    Basically the same as fft([Double]) except calling different 
    fundamental APIs of Accelerate.
    */

    let log2N = vDSP_Length(log2f(Float(realp.count)))
    let fftN = Int(1 << log2N)

    // buffers.
    var inputRealp = [Float](realp[0..<fftN])
    var inputImagp = [Float](imagp[0..<fftN])
    var fftCoefRealp = [Float](count: fftN, repeatedValue:0.0)
    var fftCoefImagp = [Float](count: fftN, repeatedValue:0.0)

    // setup DFT and execute.
    let setup = vDSP_DFT_zop_CreateSetup(nil, vDSP_Length(fftN), vDSP_DFT_Direction.FORWARD)
    vDSP_DFT_Execute(setup, &inputRealp, &inputImagp, &fftCoefRealp, &fftCoefImagp)

    // destroy setup.
    vDSP_DFT_DestroySetup(setup)

    return (fftCoefRealp, fftCoefImagp)

}

// TODOs:
func ifft(realp:[Double], imagp:[Double]) -> (realp:[Double], imagp:[Double]){
    /*
    Complex-to-Complex Inverse Fast Fourier Transform.
    */

    // Note that we only use radix-2 fft. Which means it 
    // may process only partial of the input depending on
    // the # of your samples is of power of 2 or not.

    let log2N = vDSP_Length(log2f(Float(realp.count)))
    let fftN = Int(1 << log2N)

    // buffers.
    var inputCoefRealp = [Double](realp[0..<fftN])
    var inputCoefImagp = [Double](imagp[0..<fftN])
    var outputRealp = [Double](count: fftN, repeatedValue:0.0)
    var outputImagp = [Double](count: fftN, repeatedValue:0.0)
    
    // setup DFT and execute.
    let setup = vDSP_DFT_zop_CreateSetupD(nil, vDSP_Length(fftN), vDSP_DFT_Direction.INVERSE)
    vDSP_DFT_ExecuteD(setup, &inputCoefRealp, &inputCoefImagp, &outputRealp, &outputImagp)

    // normalization of ifft
    var scale = Double(fftN)
    var normalizedOutputRealp = [Double](count: fftN, repeatedValue:0.0)
    var normalizedOutputImagp = [Double](count: fftN, repeatedValue:0.0)
    
    vDSP_vsdivD(&outputRealp, 1, &scale, &normalizedOutputRealp, 1, vDSP_Length(fftN))
    vDSP_vsdivD(&outputImagp, 1, &scale, &normalizedOutputImagp, 1, vDSP_Length(fftN))

    // destroy setup.
    vDSP_DFT_DestroySetupD(setup)

    return (normalizedOutputRealp, normalizedOutputImagp)
}

func ifft(realp:[Float], imagp:[Float]) -> (realp:[Float], imagp:[Float]){
    /*
    Complex-to-Complex Inverse Fast Fourier Transform.
    */

    // Note that we only use radix-2 fft. Which means it 
    // may process only partial of the input depending on
    // the # of your samples is of power of 2 or not.

    let log2N = vDSP_Length(log2f(Float(realp.count)))
    let fftN = Int(1 << log2N)

    // buffers.
    var inputCoefRealp = [Float](realp[0..<fftN])
    var inputCoefImagp = [Float](imagp[0..<fftN])
    var outputRealp = [Float](count: fftN, repeatedValue:0.0)
    var outputImagp = [Float](count: fftN, repeatedValue:0.0)
    
    // setup DFT and execute.
    let setup = vDSP_DFT_zop_CreateSetup(nil, vDSP_Length(fftN), vDSP_DFT_Direction.INVERSE)

    defer {

        // destroy setup.
        vDSP_DFT_DestroySetup(setup)
        
    }

    vDSP_DFT_Execute(setup, &inputCoefRealp, &inputCoefImagp, &outputRealp, &outputImagp)

    // normalization of ifft
    var scale = Float(fftN)
    var normalizedOutputRealp = [Float](count: fftN, repeatedValue:0.0)
    var normalizedOutputImagp = [Float](count: fftN, repeatedValue:0.0)
    
    vDSP_vsdiv(&outputRealp, 1, &scale, &normalizedOutputRealp, 1, vDSP_Length(fftN))
    vDSP_vsdiv(&outputImagp, 1, &scale, &normalizedOutputImagp, 1, vDSP_Length(fftN))

    return (normalizedOutputRealp, normalizedOutputImagp)
}