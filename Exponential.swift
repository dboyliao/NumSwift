#!/usr/bin/env swift
import Accelerate

func exp(x:[Float]) -> [Float] {

    /*
    Comput e^(x). (Vectorized)

    input:
        `x`: An array of floating number
    return:
        `y`: An array of floating number where its i-th elements are e^(x[i]).
    */

     var y = [Float](count: x.count, repeatedValue: 0.0)
     var N = Int32(x.count)
     vvexpf(&y, x, &N)
     return y
}

func exp(x: [Double]) -> [Double] {

    var y = [Double](count: x.count, repeatedValue: 0.0)
    var N = Int32(x.count)

    vvexp(&y, x, &N)
    return y

}

func log(x: [Float], base: Float? = nil) -> [Float] {

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

func log(x: [Double], base: Double? = nil) -> [Double] {

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
