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
 Raise each element in x to specific power.
 
 - Parameters:
    - x: An array of single precision floating numbers.
    - power: the power to raise the elements in `x` to.

 - Returns: An array of floating numbers with its i-th element be raised to
            the `power`-th power of x[i].
*/
public func pow(_ x: [Float], power: Float) -> [Float] {
    
    var y = [Float](repeating: 0.0, count: x.count)
    let powers = [Float](repeating: power, count: x.count)
    var N = Int32(x.count)

    vvpowf(&y, x, powers, &N)
    return y
}

/**
 Raise each element in x to specific power.
 
 - Parameters:
    - x: An array of double precision floating numbers.
    - power: the power to raise the elements in `x` to.
 
 - Returns: An array of floating numbers with its i-th element be raised to
            the `power`-th power of x[i].
*/
public func pow(_ x:[Double], power: Double) -> [Double] {

    var y = [Double](repeating: 0.0, count: x.count)
    let powers = [Double](repeating: power, count: x.count)
    var N = Int32(x.count)

    vvpow(&y, x, powers, &N)
    return y
}

/**
 Compute Square Root (Vectorized)
 
 - Parameters:
    - x: the input array of double precision floating numbers.
 
 - Returns: A double precision floating number array with its i-th
            element as the square root of `x[i]`
*/
public func sqrt(_ x:[Double]) -> [Double] {

    var input = [Double](x)
    var output = [Double](repeating: 0.0, count: x.count)
    var N = Int32(x.count)
    vvsqrt(&output, &input, &N)

    return output

}

/**
 Compute Square Root (Vectorized)
 
 - Parameters:
    - x: the input array of single precision floating numbers.
 
 - Returns: A single precision floating number array with its i-th
            element as the square root of `x[i]`
*/
public func sqrt(_ x:[Float]) -> [Float] {

    var input = [Float](x)
    var output = [Float](repeating: 0.0, count: x.count)
    var N = Int32(x.count)
    vvsqrtf(&output, &input, &N)

    return output

}
