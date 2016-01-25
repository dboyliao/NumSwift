import Accelerate

public func fft(realp:[Double], imagp: [Double]) -> (realp:[Double], imagp:[Double]) {

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

public func fft(realp:[Float], imagp:[Float]) -> (realp:[Float], imagp:[Float]){

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

public func ifft(realp:[Double], imagp:[Double]) -> (realp:[Double], imagp:[Double]){
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

public func ifft(realp:[Float], imagp:[Float]) -> (realp:[Float], imagp:[Float]){
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

public func fft_convolve(x:[Double], y:[Double], mode:String = "full") -> [Double] {

    var longArray:[Double]
    var shortArray:[Double]

    if x.count < y.count {

        longArray = [Double](y)
        shortArray = [Double](x)
    
    } else {

        longArray = [Double](x)
        shortArray = [Double](y)

    }

    let N = longArray.count
    let M = shortArray.count
    let convN = N+M-1
    let convNPowTwo = leastPowerOfTwo(convN)

    longArray = pad(longArray, toLength:convNPowTwo, value:0.0)
    shortArray = pad(shortArray, toLength:convNPowTwo, value:0.0)

    let zeros = [Double](count:convNPowTwo, repeatedValue:0.0)

    var (coefLongArrayRealp, coefLongArrayImagp) = fft(longArray, imagp:zeros)
    var (coefShortArrayRealp, coefShortArrayImagp) = fft(shortArray, imagp:zeros)

    // setup input buffers for vDSP_zvmulD
    // long array:
    var coefLongArrayComplex = DSPDoubleSplitComplex(realp:&coefLongArrayRealp, imagp:&coefLongArrayImagp)

    // short array:
    var coefShortArrayComplex = DSPDoubleSplitComplex(realp:&coefShortArrayRealp, imagp:&coefShortArrayImagp)

    // setup output buffers for vDSP_zvmulD
    var coefConvRealp = [Double](count:convNPowTwo, repeatedValue:0.0)
    var coefConvImagp = [Double](count:convNPowTwo, repeatedValue:0.0)
    var coefConvComplex = DSPDoubleSplitComplex(realp:&coefConvRealp, imagp:&coefConvImagp)

    // Elementwise Complex Multiplication
    vDSP_zvmulD(&coefLongArrayComplex, 1, &coefShortArrayComplex, 1,
                &coefConvComplex, 1, vDSP_Length(convNPowTwo), Int32(1))

    // ifft
    var (convResult, _) = ifft(coefConvRealp, imagp:coefConvImagp)

    // Remove padded zeros
    convResult = [Double](convResult[0..<convN])
    
    // ======== modify the result according mode before return =======
    let finalResult:[Double]

    switch mode {

        case "same":
            let numOfResultToBeRemoved = convN - N
            let toBeRemovedHalf = numOfResultToBeRemoved / 2

            if numOfResultToBeRemoved % 2 == 0 {

                finalResult = [Double](convResult[toBeRemovedHalf..<(convN-toBeRemovedHalf)])
            
            } else {

                finalResult = [Double](convResult[toBeRemovedHalf..<(convN-toBeRemovedHalf-1)])
            
            }

        case "valid":
            finalResult = [Double](convResult[(M-1)..<(convN-M+1)])

        default:
            finalResult = convResult
    }

    return finalResult
}

public func fft_convolve(x:[Float], y:[Float], mode:String = "full") -> [Float] {

    var longArray:[Float]
    var shortArray:[Float]

    if x.count < y.count {

        longArray = [Float](y)
        shortArray = [Float](x)
    
    } else {

        longArray = [Float](x)
        shortArray = [Float](y)

    }

    let N = longArray.count
    let M = shortArray.count
    let convN = N+M-1
    let convNPowTwo = leastPowerOfTwo(convN)

    longArray = pad(longArray, toLength:convNPowTwo, value:0.0)
    shortArray = pad(shortArray, toLength:convNPowTwo, value:0.0)

    let zeros = [Float](count:convNPowTwo, repeatedValue:0.0)

    var (coefLongArrayRealp, coefLongArrayImagp) = fft(longArray, imagp:zeros)
    var (coefShortArrayRealp, coefShortArrayImagp) = fft(shortArray, imagp:zeros)

    // setup input buffers for vDSP_zvmulD
    // long array:
    var coefLongArrayComplex = DSPSplitComplex(realp:&coefLongArrayRealp, imagp:&coefLongArrayImagp)

    // short array:
    var coefShortArrayComplex = DSPSplitComplex(realp:&coefShortArrayRealp, imagp:&coefShortArrayImagp)

    // setup output buffers for vDSP_zvmulD
    var coefConvRealp = [Float](count:convNPowTwo, repeatedValue:0.0)
    var coefConvImagp = [Float](count:convNPowTwo, repeatedValue:0.0)
    var coefConvComplex = DSPSplitComplex(realp:&coefConvRealp, imagp:&coefConvImagp)

    // Elementwise Complex Multiplication
    vDSP_zvmul(&coefLongArrayComplex, 1, &coefShortArrayComplex, 1,
                &coefConvComplex, 1, vDSP_Length(convNPowTwo), Int32(1))

    // ifft
    var (convResult, _) = ifft(coefConvRealp, imagp:coefConvImagp)

    // Remove padded zeros
    convResult = [Float](convResult[0..<convN])
    
    // ======== modify the result according mode before return =======
    let finalResult:[Float]

    switch mode {

        case "same":
            let numOfResultToBeRemoved = convN - N
            let toBeRemovedHalf = numOfResultToBeRemoved / 2

            if numOfResultToBeRemoved % 2 == 0 {

                finalResult = [Float](convResult[toBeRemovedHalf..<(convN-toBeRemovedHalf)])
            
            } else {

                finalResult = [Float](convResult[toBeRemovedHalf..<(convN-toBeRemovedHalf-1)])
            
            }

        case "valid":
            finalResult = [Float](convResult[(M-1)..<(convN-M+1)])

        default:
            finalResult = convResult
    }

    return finalResult
}