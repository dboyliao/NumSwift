import Accelerate

public func exp(x:[Float]) -> [Float] {

    /*
    Compute e^(x). (Vectorized)

    input:
        `x`: An array of floating numbers.
    return:
        `y`: An array of floating number where its i-th element is e^(x[i]).
    */

     var y = [Float](count: x.count, repeatedValue: 0.0)
     var N = Int32(x.count)
     vvexpf(&y, x, &N)
     return y
}

public func exp(x: [Double]) -> [Double] {
    /*
    Compute e^(x). (Vectorized)

    input:
        `x`: An array of double-precision floating numbers.
    return:
        `y`: An array of double-precision floating numbers where its i-th element is e^(x[i])
    */

    var y = [Double](count: x.count, repeatedValue: 0.0)
    var N = Int32(x.count)

    vvexp(&y, x, &N)
    return y

}

public func log(x: [Float], base: Float? = nil) -> [Float] {

    /*
    Compute logrithm with base.

    input:
        `x`: An array of floating numbers.
        `base`: Optional floating number. It is natural exponential by default.
    return:
        `y`: An array of floating numbers. Its i-th element is the logrithm of x[i] 
             with base as given by `base`.
    */

    var y = [Float](count: x.count, repeatedValue: 0.0)
    var N = Int32(x.count)

    vvlogf(&y, x, &N)

    if base != nil {
        var base = base!
        var scale:Float = 0.0
        var one = Int32(1)
        var tempArray = [Float](count: y.count, repeatedValue: 0.0)

        vvlogf(&scale, &base, &one)
        vDSP_vsdiv(&y, 1, &scale, &tempArray, 1, vDSP_Length(y.count))
        y = tempArray
    }

    return y
}

public func log(x: [Double], base: Double? = nil) -> [Double] {

    /*
    Compute logrithm with base.

    input:
        `x`: An array of double-precision floating numbers.
        `base`: Optional double-precision floating number. It is natural exponential
                by default.
    return:
        `y`: An array of double-precision floating numbers. Its i-th element is the 
            logrithm of x[i] with base as given by `base`.
    */

    var y = [Double](count: x.count, repeatedValue: 0.0)
    var N = Int32(x.count)

    vvlog(&y, x, &N)
    if base != nil {
        var base = base!
        var scale: Double = 0.0
        var one = Int32(1)
        var tempArray = [Double](count: y.count, repeatedValue: 0.0)

        vvlog(&scale, &base, &one)
        vDSP_vsdivD(&y, 1, &scale, &tempArray, 1, vDSP_Length(y.count))
        y = tempArray
    }

    return y
}
