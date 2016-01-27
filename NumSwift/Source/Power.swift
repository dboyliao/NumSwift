import Accelerate

/**
 Raise each element in x to specific power.
 
 - Parameters:
    - x: An array of single precision floating numbers.
    - power: the power to raise the elements in `x` to.

 - Returns: An array of floating numbers with its i-th element be raised to
            the `power`-th power of x[i].
*/
public func pow(x: [Float], power: Float) -> [Float] {
    
    var y = [Float](count: x.count, repeatedValue: 0.0)
    let powers = [Float](count: x.count, repeatedValue: power)
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
public func pow(x:[Double], power: Double) -> [Double] {

    var y = [Double](count: x.count, repeatedValue: 0.0)
    let powers = [Double](count: x.count, repeatedValue: power)
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
public func sqrt(x:[Double]) -> [Double] {

    var input = [Double](x)
    var output = [Double](count:x.count, repeatedValue:0.0)
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
public func sqrt(x:[Float]) -> [Float] {

    var input = [Float](x)
    var output = [Float](count:x.count, repeatedValue:0.0)
    var N = Int32(x.count)
    vvsqrtf(&output, &input, &N)

    return output

}
