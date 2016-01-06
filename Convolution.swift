import Accelerate

func convolve(x:[Double], y:[Double], mode: String = "full") -> [Double]? {

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

            finalOutput = [Double](output[toBeRemovedHalf..<(convN-toBeRemovedHalf+1)])
        
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

            finalOutput = [Float](output[toBeRemovedHalf..<(convN-toBeRemovedHalf+1)])
        
        }
    } else if mode == "valid" {
        
        finalOutput = [Float](output[(M-1)..<(convN-M+1)])

    } else {

        finalOutput = nil

    }

    return finalOutput

}

// func fft_convolve(x:[Double], y:[Double], mode: String) -> [Double] {

// }

// func fft_convolve(x:[Float], y:[Float], mode: String) -> [Float] {

    
// }