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
 Compute e^(x). (Vectorized)
 
 - Parameters:
    - x: array of single precision floating numbers.
 
 - Returns: An array of single precision floating number where its i-th element is e^(x[i]).
*/
public func exp(_ x:[Float]) -> [Float] {
    
     var y = [Float](repeating: 0.0, count: x.count)
     var N = Int32(x.count)
     vvexpf(&y, x, &N)
     return y
}


/**
 Compute e^(x). (Vectorized)
 
 - Parameters:
    - x: array of double precision floating numbers.
 
 - Returns: An array of double precision floating number where its i-th element is e^(x[i]).
*/
public func exp(_ x: [Double]) -> [Double] {
    
    var y = [Double](repeating: 0.0, count: x.count)
    var N = Int32(x.count)

    vvexp(&y, x, &N)
    return y

}

/**
 Logrithm with Base
 
 - Parameters:
    - x: array of single precision floating numbers.
    - base: the base of the logrithm (default: `e`).
 
 - Returns: An array of single precision floating numbers. Its i-th element is the logrithm of x[i]
            with base as given by `base`.
*/
public func log(_ x: [Float], base: Float? = nil) -> [Float] {

    var y = [Float](repeating: 0.0, count: x.count)
    var N = Int32(x.count)

    vvlogf(&y, x, &N)

    if base != nil {
        var base = base!
        var scale:Float = 0.0
        var one = Int32(1)
        var tempArray = [Float](repeating: 0.0, count: y.count)

        vvlogf(&scale, &base, &one)
        vDSP_vsdiv(&y, 1, &scale, &tempArray, 1, vDSP_Length(y.count))
        y = tempArray
    }

    return y
}

/**
 Logrithm with Base
 
 - Parameters:
    - x: array of double precision floating numbers.
    - base: the base of the logrithm (default: `e`).
 
    - Returns: An array of double precision floating numbers. Its i-th element is the logrithm of x[i]
               with base as given by `base`.
*/
public func log(_ x: [Double], base: Double? = nil) -> [Double] {

    var y = [Double](repeating: 0.0, count: x.count)
    var N = Int32(x.count)

    vvlog(&y, x, &N)
    if base != nil {
        var base = base!
        var scale: Double = 0.0
        var one = Int32(1)
        var tempArray = [Double](repeating: 0.0, count: y.count)

        vvlog(&scale, &base, &one)
        vDSP_vsdivD(&y, 1, &scale, &tempArray, 1, vDSP_Length(y.count))
        y = tempArray
    }

    return y
}
