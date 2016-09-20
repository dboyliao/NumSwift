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
 Return sorted array in ascending or descending order (with Accelerate framework).
 
 - Parameters:
    - x: array to be sorted.
    - order: `1` for ascending order, `-1` for descending order.
 
 - Returns: a sorted array.
*/
public func sort(_ x: [Double], order:Int) -> [Double]{

    var input = [Double](x)

    vDSP_vsortD(&input, vDSP_Length(order), Int32(order))

    return input
}

/**
 Return sorted array in ascending or descending order (with Accelerate framework).
 
 - Parameters:
    - x: array to be sorted.
    - order: `1` for ascending order, `-1` for descending order.
 
 - Returns: a sorted array.
*/
public func sort(_ x: [Float], order:Int) -> [Float]{
    
    var input = [Float](x)

    vDSP_vsort(&input, vDSP_Length(order), Int32(order))

    return input
}
