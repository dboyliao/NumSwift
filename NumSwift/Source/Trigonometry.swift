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
public func sin(x:[Double]) -> [Double] {
    var N = Int32(x.count)
    var y = [Double](count:x.count, repeatedValue: 0.0)

    vvsin(&y, x, &N)
    return y
}

/**
 Trigonometric Sine.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of sine values of each element in x.
*/
public func sin(x:[Float]) -> [Float] {
    var N = Int32(x.count)
    var y = [Float](count: x.count, repeatedValue: 0.0)

    vvsinf(&y, x, &N)
    return y
}

/**
 Trigonometric Cosecant.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of cosecant values of each element in x.
*/
public func csc(x:[Double]) -> [Double]{

    var y = sin(x)
    var output = [Double](count: y.count, repeatedValue:0.0)
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
public func csc(x:[Float]) -> [Float]{

    var y = sin(x)
    var output = [Float](count: y.count, repeatedValue:0.0)
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
public func cos(x:[Double]) -> [Double]{
    var N = Int32(x.count)
    var y = [Double](count: x.count, repeatedValue: 0.0)

    vvcos(&y, x, &N)
    return y
}

/**
 Trigonometric Cosine.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of cosine values of each element in x.
*/
public func cos(x:[Float]) -> [Float]{
    var N = Int32(x.count)
    var y = [Float](count: x.count, repeatedValue: 0.0)

    vvcosf(&y, x, &N)
    return y
}

/**
 Trigonometric Secant.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of secant values of each element in x.
*/
public func sec(x:[Double]) -> [Double]{

    var y = cos(x)
    var output = [Double](count: y.count, repeatedValue:0.0)
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
public func sec(x:[Float]) -> [Float]{

    var y = cos(x)
    var output = [Float](count: y.count, repeatedValue:0.0)
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
public func tan(x:[Double]) -> [Double] {
    var N = Int32(x.count)
    var y = [Double](count: x.count, repeatedValue: 0.0)

    vvtan(&y, x, &N)
    return y
}

/**
 Trigonometric Tangent.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of tangent values of each element in x.
*/
public func tan(x:[Float]) -> [Float] {
    var N = Int32(x.count)
    var y = [Float](count: x.count, repeatedValue: 0.0)

    vvtanf(&y, x, &N)
    return y
}

/**
 Trigonometric Cotangent.
 
 - Parameters:
    - x: array of angles (in radian).
 
 - Returns: A array of cotangent values of each element in x.
*/
public func cot(x:[Double]) -> [Double]{
    
    var y = tan(x)
    var output = [Double](count:y.count, repeatedValue:0.0)
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
public func cot(x:[Float]) -> [Float]{
    
    var y = tan(x)
    var output = [Float](count:y.count, repeatedValue:0.0)
    var one:Float = 1.0
    let N = vDSP_Length(y.count)

    vDSP_svdiv(&one, &y, 1, &output, 1, N)
    return output
}
