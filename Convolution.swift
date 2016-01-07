import Accelerate
import Foundation

func convolve(x:[Double], y:[Double], mode:String = "full") -> [Double]? {

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
    let output = [Double](count:convN, repeatedValue:0.0)

    // padding leading zeros
    longArray = [Double](count:(convN-N), repeatedValue:0.0) + longArray

    let ptr_longArrayFirstElement = UnsafePointer<Double>(longArray)
    let ptr_shortArrayLastElement = UnsafePointer<Double>(shortArray).advancedBy(shortArray.count - 1)
    let ptr_output = UnsafeMutablePointer<Double>(output)

    vDSP_convD(ptr_longArrayFirstElement, 1, ptr_shortArrayLastElement, -1, 
               ptr_output, 1, vDSP_Length(convN), vDSP_Length(M))

    let finalOutput:[Double]?

    if mode == "full" {

        finalOutput = output

    } else if mode == "same" {

        let numOfResultToBeRemoved = convN - N
        let toBeRemovedHalf = numOfResultToBeRemoved / 2

        if numOfResultToBeRemoved % 2 == 0 {

            finalOutput = [Double](output[toBeRemovedHalf..<(convN-toBeRemovedHalf)])
        
        } else {

            finalOutput = [Double](output[toBeRemovedHalf..<(convN-toBeRemovedHalf-1)])
        
        }

    } else if mode == "valid" {

        finalOutput = [Double](output[(M-1)..<(convN-M+1)])

    } else {

        finalOutput = nil

    }

    return finalOutput
}

func convolve(x:[Float], y:[Float], mode: String = "full") -> [Float]? {

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
    let output = [Float](count:convN, repeatedValue:0.0)

    // padding leading zeros
    longArray = [Float](count:(convN-N), repeatedValue:0.0) + longArray

    let ptr_longArrayFirstElement = UnsafePointer<Float>(longArray)
    let ptr_shortArrayLastElement = UnsafePointer<Float>(shortArray).advancedBy(shortArray.count - 1)
    let ptr_output = UnsafeMutablePointer<Float>(output)

    vDSP_conv(ptr_longArrayFirstElement, 1, ptr_shortArrayLastElement, -1, 
               ptr_output, 1, vDSP_Length(convN), vDSP_Length(M))

    let finalOutput:[Float]?

    if mode == "full" {

        finalOutput = output

    } else if mode == "same" {

        let numOfResultToBeRemoved = convN - N
        let toBeRemovedHalf = numOfResultToBeRemoved / 2

        if numOfResultToBeRemoved % 2 == 0 {

            finalOutput = [Float](output[toBeRemovedHalf..<(convN-toBeRemovedHalf)])
        
        } else {

            finalOutput = [Float](output[toBeRemovedHalf..<(convN-toBeRemovedHalf-1)])
        
        }
    } else if mode == "valid" {
        
        finalOutput = [Float](output[(M-1)..<(convN-M+1)])

    } else {

        finalOutput = nil

    }

    return finalOutput

}

func fft_convolve(x:[Double], y:[Double], mode:String = "full") -> [Double]? {

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

    longArray = pad(longArray, value:0.0, toLength:convNPowTwo)
    shortArray = pad(shortArray, value:0.0, toLength:convNPowTwo)

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
    let finalResult:[Double]?

    if mode == "full" {

        finalResult = convResult

    } else if mode == "same" {

        let numOfResultToBeRemoved = convN - N
        let toBeRemovedHalf = numOfResultToBeRemoved / 2

        if numOfResultToBeRemoved % 2 == 0 {

            finalResult = [Double](convResult[toBeRemovedHalf..<(convN-toBeRemovedHalf)])
        
        } else {

            finalResult = [Double](convResult[toBeRemovedHalf..<(convN-toBeRemovedHalf-1)])
        
        }
    } else if mode == "valid" {
        
        finalResult = [Double](convResult[(M-1)..<(convN-M+1)])

    } else {

        finalResult = nil

    }

    return finalResult
}

func fft_convolve(x:[Float], y:[Float], mode:String = "full") -> [Float]? {

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

    longArray = pad(longArray, value:0.0, toLength:convNPowTwo)
    shortArray = pad(shortArray, value:0.0, toLength:convNPowTwo)

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
    let finalResult:[Float]?

    if mode == "full" {

        finalResult = convResult

    } else if mode == "same" {

        let numOfResultToBeRemoved = convN - N
        let toBeRemovedHalf = numOfResultToBeRemoved / 2

        if numOfResultToBeRemoved % 2 == 0 {

            finalResult = [Float](convResult[toBeRemovedHalf..<(convN-toBeRemovedHalf)])
        
        } else {

            finalResult = [Float](convResult[toBeRemovedHalf..<(convN-toBeRemovedHalf-1)])
        
        }
    } else if mode == "valid" {
        
        finalResult = [Float](convResult[(M-1)..<(convN-M+1)])

    } else {

        finalResult = nil

    }

    return finalResult
}