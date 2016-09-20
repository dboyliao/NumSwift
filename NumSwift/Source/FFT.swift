//
// Dear maintainer:
//
// When I wrote this code, only I and God
// know what it was.
// Now, only God knows!
//
// So if you are done trying to 'optimize'
// this routine (and failed),
// please increment the following counter
// as warning to the next guy:
//
// var TotalHoursWastedHere = 0
//
// Reference: http://stackoverflow.com/questions/184618/what-is-the-best-comment-in-source-code-you-have-ever-encountered

import Accelerate

/**
 Complex-to-Complex Fast Fourier Transform.
 
 - Note: we use radix-2 fft. As a result, it may process only partial input
         data depending on the # of data is of power of 2 or not.
 
 - Parameters:
    - realp: real part of input data
    - imagp: imaginary part of input data
 
 - Returns:
    - `(realp:[Double], imagp:[Double])`: Fourier coeficients. It's a tuple with named
      attributes, `realp` and `imagp`.
*/
public func fft(_ realp:[Double], imagp: [Double]) -> (realp:[Double], imagp:[Double]) {

    let log2N = vDSP_Length(log2f(Float(realp.count)))
    let fftN = Int(1 << log2N)

    // buffers.
    var inputRealp = [Double](realp[0..<fftN])
    var inputImagp = [Double](imagp[0..<fftN])
    var fftCoefRealp = [Double](repeating: 0.0, count: fftN)
    var fftCoefImagp = [Double](repeating: 0.0, count: fftN)

    // setup DFT and execute.
    let setup = vDSP_DFT_zop_CreateSetupD(nil, vDSP_Length(fftN), vDSP_DFT_Direction.FORWARD)
    vDSP_DFT_ExecuteD(setup!, &inputRealp, &inputImagp, &fftCoefRealp, &fftCoefImagp)

    // destroy setup.
    vDSP_DFT_DestroySetupD(setup)

    return (fftCoefRealp, fftCoefImagp)
}


/**
 Complex-to-Complex Fast Fourier Transform.
 
 - Note: that we use radix-2 fft. As a result, it may process only partial input
         data depending on the # of data is of power of 2 or not.
 
 - Parameters:
    - realp: real part of input data
    - imagp: imaginary part of input data
 
 - Returns: `(realp:[Float], imagp:[Float])`: Fourier coeficients. It's a tuple with named
      attributes, `realp` and `imagp`.
*/
public func fft(_ realp:[Float], imagp:[Float]) -> (realp:[Float], imagp:[Float]){

    let log2N = vDSP_Length(log2f(Float(realp.count)))
    let fftN = Int(1 << log2N)

    // buffers.
    var inputRealp = [Float](realp[0..<fftN])
    var inputImagp = [Float](imagp[0..<fftN])
    var fftCoefRealp = [Float](repeating: 0.0, count: fftN)
    var fftCoefImagp = [Float](repeating: 0.0, count: fftN)

    // setup DFT and execute.
    let setup = vDSP_DFT_zop_CreateSetup(nil, vDSP_Length(fftN), vDSP_DFT_Direction.FORWARD)
    vDSP_DFT_Execute(setup!, &inputRealp, &inputImagp, &fftCoefRealp, &fftCoefImagp)

    // destroy setup.
    vDSP_DFT_DestroySetup(setup)

    return (fftCoefRealp, fftCoefImagp)

}

/**
 Complex-to-Complex Inverse Fast Fourier Transform.

 - Note: we use radix-2 Inverse Fast Fourier Transform. As a result, it may process
         only partial input data depending on the # of data is of power of 2 or not.
 
 - Parameters:
    - realp: real part of input data
    - imagp: imaginary part of input data
 
 - Returns: `(realp:[Double], imagp:[Double])`: Fourier coeficients. It's a tuple with named
            attributes, `realp` and `imagp`.
*/
public func ifft(_ realp:[Double], imagp:[Double]) -> (realp:[Double], imagp:[Double]){

    let log2N = vDSP_Length(log2f(Float(realp.count)))
    let fftN = Int(1 << log2N)

    // buffers.
    var inputCoefRealp = [Double](realp[0..<fftN])
    var inputCoefImagp = [Double](imagp[0..<fftN])
    var outputRealp = [Double](repeating: 0.0, count: fftN)
    var outputImagp = [Double](repeating: 0.0, count: fftN)
    
    // setup DFT and execute.
    let setup = vDSP_DFT_zop_CreateSetupD(nil, vDSP_Length(fftN), vDSP_DFT_Direction.INVERSE)
    vDSP_DFT_ExecuteD(setup!, &inputCoefRealp, &inputCoefImagp, &outputRealp, &outputImagp)

    // normalization of ifft
    var scale = Double(fftN)
    var normalizedOutputRealp = [Double](repeating: 0.0, count: fftN)
    var normalizedOutputImagp = [Double](repeating: 0.0, count: fftN)
    
    vDSP_vsdivD(&outputRealp, 1, &scale, &normalizedOutputRealp, 1, vDSP_Length(fftN))
    vDSP_vsdivD(&outputImagp, 1, &scale, &normalizedOutputImagp, 1, vDSP_Length(fftN))

    // destroy setup.
    vDSP_DFT_DestroySetupD(setup)

    return (normalizedOutputRealp, normalizedOutputImagp)
}

/**
 Complex-to-Complex Inverse Fast Fourier Transform.
 
 - Note: we use radix-2 Inverse Fast Fourier Transform. As a result, it may process 
         only partial input data depending on the # of data is of power of 2 or not.
 
 - Parameters:
    - realp: real part of input data
    - imagp: imaginary part of input data
 
 - Returns: `(realp:[Float], imagp:[Float])`: Fourier coeficients. It's a tuple with named
            attributes, `realp` and `imagp`.
 */
public func ifft(_ realp:[Float], imagp:[Float]) -> (realp:[Float], imagp:[Float]){
    
    let log2N = vDSP_Length(log2f(Float(realp.count)))
    let fftN = Int(1 << log2N)

    // buffers.
    var inputCoefRealp = [Float](realp[0..<fftN])
    var inputCoefImagp = [Float](imagp[0..<fftN])
    var outputRealp = [Float](repeating: 0.0, count: fftN)
    var outputImagp = [Float](repeating: 0.0, count: fftN)
    
    // setup DFT and execute.
    let setup = vDSP_DFT_zop_CreateSetup(nil, vDSP_Length(fftN), vDSP_DFT_Direction.INVERSE)

    defer {

        // destroy setup.
        vDSP_DFT_DestroySetup(setup)
        
    }

    vDSP_DFT_Execute(setup!, &inputCoefRealp, &inputCoefImagp, &outputRealp, &outputImagp)

    // normalization of ifft
    var scale = Float(fftN)
    var normalizedOutputRealp = [Float](repeating: 0.0, count: fftN)
    var normalizedOutputImagp = [Float](repeating: 0.0, count: fftN)
    
    vDSP_vsdiv(&outputRealp, 1, &scale, &normalizedOutputRealp, 1, vDSP_Length(fftN))
    vDSP_vsdiv(&outputImagp, 1, &scale, &normalizedOutputImagp, 1, vDSP_Length(fftN))

    return (normalizedOutputRealp, normalizedOutputImagp)
}

/**
 Convolution with Fast Fourier Transform
 
 Perform convolution by Fast Fourier Transform
 
 - Parameters:
    - x: input array for convolution.
    - y: input array for convolution.
    - mode: mode of the convolution.
        - "full": return full result (default).
        - "same": return result with the same length as the longest input arrays between x and y.
        - "valid": only return the result given for points where two arrays overlap completely.
 
 - Returns: the result of the convolution of x and y.
*/
public func fft_convolve(_ x:[Double], y:[Double], mode:String = "full") -> [Double] {

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

    let zeros = [Double](repeating: 0.0, count: convNPowTwo)

    var (coefLongArrayRealp, coefLongArrayImagp) = fft(longArray, imagp:zeros)
    var (coefShortArrayRealp, coefShortArrayImagp) = fft(shortArray, imagp:zeros)

    // setup input buffers for vDSP_zvmulD
    // long array:
    var coefLongArrayComplex = DSPDoubleSplitComplex(realp:&coefLongArrayRealp, imagp:&coefLongArrayImagp)

    // short array:
    var coefShortArrayComplex = DSPDoubleSplitComplex(realp:&coefShortArrayRealp, imagp:&coefShortArrayImagp)

    // setup output buffers for vDSP_zvmulD
    var coefConvRealp = [Double](repeating: 0.0, count: convNPowTwo)
    var coefConvImagp = [Double](repeating: 0.0, count: convNPowTwo)
    var coefConvComplex = DSPDoubleSplitComplex(realp:&coefConvRealp, imagp:&coefConvImagp)

    // Elementwise Complex Multiplication
    vDSP_zvmulD(&coefLongArrayComplex, 1, &coefShortArrayComplex, 1,
                &coefConvComplex, 1, vDSP_Length(convNPowTwo), Int32(1))

    // ifft
    var (convResult, _) = ifft(coefConvRealp, imagp:coefConvImagp)

    // Remove padded zeros
    convResult = [Double](convResult[0..<convN])
    
    // modify the result according mode before return
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

/**
 Convolution with Fast Fourier Transform
 
 Perform convolution by Fast Fourier Transform
 
 - Parameters:
    - x: input array for convolution.
    - y: input array for convolution.
    - mode: mode of the convolution.
        - "full": return full result (default).
        - "same": return result with the same length as the longest input array between x and y.
        - "valid": only return the result given for points where two arrays overlap completely.
 
 - Returns: the result of the convolution of x and y.
*/
public func fft_convolve(_ x:[Float], y:[Float], mode:String = "full") -> [Float] {

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

    let zeros = [Float](repeating: 0.0, count: convNPowTwo)

    var (coefLongArrayRealp, coefLongArrayImagp) = fft(longArray, imagp:zeros)
    var (coefShortArrayRealp, coefShortArrayImagp) = fft(shortArray, imagp:zeros)

    // setup input buffers for vDSP_zvmulD
    // long array:
    var coefLongArrayComplex = DSPSplitComplex(realp:&coefLongArrayRealp, imagp:&coefLongArrayImagp)

    // short array:
    var coefShortArrayComplex = DSPSplitComplex(realp:&coefShortArrayRealp, imagp:&coefShortArrayImagp)

    // setup output buffers for vDSP_zvmulD
    var coefConvRealp = [Float](repeating: 0.0, count: convNPowTwo)
    var coefConvImagp = [Float](repeating: 0.0, count: convNPowTwo)
    var coefConvComplex = DSPSplitComplex(realp:&coefConvRealp, imagp:&coefConvImagp)

    // Elementwise Complex Multiplication
    vDSP_zvmul(&coefLongArrayComplex, 1, &coefShortArrayComplex, 1,
                &coefConvComplex, 1, vDSP_Length(convNPowTwo), Int32(1))

    // ifft
    var (convResult, _) = ifft(coefConvRealp, imagp:coefConvImagp)

    // Remove padded zeros
    convResult = [Float](convResult[0..<convN])
    
    // modify the result according mode before return
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
