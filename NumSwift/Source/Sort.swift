import Accelerate

/**
 Return sorted array in ascending or descending order (with Accelerate framework).
 
 - Parameters:
    - x: array to be sorted.
    - order: `1` for ascending order, `-1` for descending order.
 
 - Returns: a sorted array.
*/
public func sort(x: [Double], order:Int) -> [Double]{

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
public func sort(x: [Float], order:Int) -> [Float]{
    
    var input = [Float](x)

    vDSP_vsort(&input, vDSP_Length(order), Int32(order))

    return input
}