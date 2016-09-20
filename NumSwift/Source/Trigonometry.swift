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
 Trigonometric Sine.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of sine values of each element in x.
*/
public func sin(_ x:[Double]) -> [Double] {
    var N = Int32(x.count)
    var y = [Double](repeating: 0.0, count: x.count)

    vvsin(&y, x, &N)
    return y
}

/**
 Trigonometric Sine.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of sine values of each element in x.
*/
public func sin(_ x:[Float]) -> [Float] {
    var N = Int32(x.count)
    var y = [Float](repeating: 0.0, count: x.count)

    vvsinf(&y, x, &N)
    return y
}

/**
 Trigonometric Cosecant.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of cosecant values of each element in x.
*/
public func csc(_ x:[Double]) -> [Double]{

    var y = sin(x)
    var output = [Double](repeating: 0.0, count: y.count)
    let N = vDSP_Length(y.count)
    var one = 1.0

    vDSP_svdivD(&one, &y, 1, &output, 1, N)
    return output
}

/**
 Trigonometric Cosecant.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of cosecant values of each element in x.
*/
public func csc(_ x:[Float]) -> [Float]{

    var y = sin(x)
    var output = [Float](repeating: 0.0, count: y.count)
    let N = vDSP_Length(y.count)
    var one:Float = 1.0

    vDSP_svdiv(&one, &y, 1, &output, 1, N)
    return output
}

/**
 Trigonometric Cosine.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of cosine values of each element in x.
*/
public func cos(_ x:[Double]) -> [Double]{
    var N = Int32(x.count)
    var y = [Double](repeating: 0.0, count: x.count)

    vvcos(&y, x, &N)
    return y
}

/**
 Trigonometric Cosine.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of cosine values of each element in x.
*/
public func cos(_ x:[Float]) -> [Float]{
    var N = Int32(x.count)
    var y = [Float](repeating: 0.0, count: x.count)

    vvcosf(&y, x, &N)
    return y
}

/**
 Trigonometric Secant.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of secant values of each element in x.
*/
public func sec(_ x:[Double]) -> [Double]{

    var y = cos(x)
    var output = [Double](repeating: 0.0, count: y.count)
    let N = vDSP_Length(y.count)
    var one = 1.0

    vDSP_svdivD(&one, &y, 1, &output, 1, N)
    return output
}

/**
 Trigonometric Secant.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of secant values of each element in x.
*/
public func sec(_ x:[Float]) -> [Float]{

    var y = cos(x)
    var output = [Float](repeating: 0.0, count: y.count)
    let N = vDSP_Length(y.count)
    var one:Float = 1.0

    vDSP_svdiv(&one, &y, 1, &output, 1, N)
    return output
}

/**
 Trigonometric Tangent.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of tangent values of each element in x.
*/
public func tan(_ x:[Double]) -> [Double] {
    var N = Int32(x.count)
    var y = [Double](repeating: 0.0, count: x.count)

    vvtan(&y, x, &N)
    return y
}

/**
 Trigonometric Tangent.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of tangent values of each element in x.
*/
public func tan(_ x:[Float]) -> [Float] {
    var N = Int32(x.count)
    var y = [Float](repeating: 0.0, count: x.count)

    vvtanf(&y, x, &N)
    return y
}

/**
 Trigonometric Cotangent.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of cotangent values of each element in x.
*/
public func cot(_ x:[Double]) -> [Double]{
    
    var y = tan(x)
    var output = [Double](repeating: 0.0, count: y.count)
    var one = 1.0
    let N = vDSP_Length(y.count)

    vDSP_svdivD(&one, &y, 1, &output, 1, N)
    return output
}

/**
 Trigonometric Cotangent.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of cotangent values of each element in x.
*/
public func cot(_ x:[Float]) -> [Float]{
    
    var y = tan(x)
    var output = [Float](repeating: 0.0, count: y.count)
    var one:Float = 1.0
    let N = vDSP_Length(y.count)

    vDSP_svdiv(&one, &y, 1, &output, 1, N)
    return output
}
