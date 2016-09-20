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
import Foundation

/**
 1D Convolution
 
 - Parameters:
    - x: a double array
    - y: a double array
    - mode: mode of the convolution.
        - "full": return full result (default).
        - "same": return result with the same length as the longest input arrays, x and y.
        - "valid": only return the result given for points where two arrays overlap completely.
 
 - Returns: The result of x convolving y.
*/
public func convolve(_ x:[Double], y:[Double], mode:String = "full") -> [Double] {

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
    let output = [Double](repeating: 0.0, count: convN)

    // padding leading zeros
    longArray = [Double](repeating: 0.0, count: (convN-N)) + longArray

    let ptr_longArrayFirstElement = UnsafePointer<Double>(longArray)
    let ptr_shortArrayLastElement = UnsafePointer<Double>(shortArray).advanced(by:shortArray.count - 1)
    let ptr_output = UnsafeMutablePointer<Double>(mutating: output)

    vDSP_convD(ptr_longArrayFirstElement, 1, ptr_shortArrayLastElement, -1, 
               ptr_output, 1, vDSP_Length(convN), vDSP_Length(M))

    let finalOutput:[Double]

    switch (mode) {

        case "same":
            let numOfResultToBeRemoved = convN - N
            let toBeRemovedHalf = numOfResultToBeRemoved / 2

            if numOfResultToBeRemoved % 2 == 0 {
                finalOutput = [Double](output[toBeRemovedHalf..<(convN-toBeRemovedHalf)])
            } else {
                finalOutput = [Double](output[toBeRemovedHalf..<(convN-toBeRemovedHalf-1)])
            }

        case "valid":
            finalOutput = [Double](output[(M-1)..<(convN-M+1)])

        default:
            finalOutput = output
    }

    return finalOutput
}

/**
 1D Convolution
 
 - Parameters:
    - x: a double array
    - y: a double array
    - mode: mode of the convolution.
        - "full": return full result (default).
        - "same": return result with the same length as the longest input arrays, x and y.
        - "valid": only return the result given for points where two arrays overlap completely.
 
 - Returns: The result of x convolving y.
 */
public func convolve(_ x:[Float], y:[Float], mode: String = "full") -> [Float] {

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
    let output = [Float](repeating: 0.0, count: convN)

    // padding leading zeros
    longArray = [Float](repeating: 0.0, count: (convN-N)) + longArray

    let ptr_longArrayFirstElement = UnsafePointer<Float>(longArray)
    let ptr_shortArrayLastElement = UnsafePointer<Float>(shortArray).advanced(by:shortArray.count - 1)
    let ptr_output = UnsafeMutablePointer<Float>(mutating: output)

    vDSP_conv(ptr_longArrayFirstElement, 1, ptr_shortArrayLastElement, -1, 
               ptr_output, 1, vDSP_Length(convN), vDSP_Length(M))

    let finalOutput:[Float]

    switch (mode) {

        case "same":
            let numOfResultToBeRemoved = convN - N
            let toBeRemovedHalf = numOfResultToBeRemoved / 2

            if numOfResultToBeRemoved % 2 == 0 {
                finalOutput = [Float](output[toBeRemovedHalf..<(convN-toBeRemovedHalf)])
            } else {
                finalOutput = [Float](output[toBeRemovedHalf..<(convN-toBeRemovedHalf-1)])
            }

        case "valid":
            finalOutput = [Float](output[(M-1)..<(convN-M+1)])

        default:
            finalOutput = output
    }

    return finalOutput

}
