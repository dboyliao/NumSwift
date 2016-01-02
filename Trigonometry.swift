import Accelerate

func sin(x:[Double]) -> [Double] {
    var N = Int32(x.count)
    var y = [Double](count:x.count, repeatedValue: 0.0)

    vvsin(&y, x, &N)
    return y
}

func sin(x:[Float]) -> [Float] {
    var N = Int32(x.count)
    var y = [Float](count: x.count, repeatedValue: 0.0)

    vvsinf(&y, x, &N)
    return y
}

func csc(x:[Double]) -> [Double]{

    var y = sin(x)
    var output = [Double](count: y.count, repeatedValue:0.0)
    let N = vDSP_Length(y.count)
    var one = 1.0

    vDSP_svdivD(&one, &y, 1, &output, 1, N)
    return output
}

func csc(x:[Float]) -> [Float]{

    var y = sin(x)
    var output = [Float](count: y.count, repeatedValue:0.0)
    let N = vDSP_Length(y.count)
    var one:Float = 1.0

    vDSP_svdiv(&one, &y, 1, &output, 1, N)
    return output
}

func cos(x:[Double]) -> [Double]{
    var N = Int32(x.count)
    var y = [Double](count: x.count, repeatedValue: 0.0)

    vvcos(&y, x, &N)
    return y
}

func cos(x:[Float]) -> [Float]{
    var N = Int32(x.count)
    var y = [Float](count: x.count, repeatedValue: 0.0)

    vvcosf(&y, x, &N)
    return y
}

func sec(x:[Double]) -> [Double]{

    var y = cos(x)
    var output = [Double](count: y.count, repeatedValue:0.0)
    let N = vDSP_Length(y.count)
    var one = 1.0

    vDSP_svdivD(&one, &y, 1, &output, 1, N)
    return output
}

func sec(x:[Float]) -> [Float]{

    var y = cos(x)
    var output = [Float](count: y.count, repeatedValue:0.0)
    let N = vDSP_Length(y.count)
    var one:Float = 1.0

    vDSP_svdiv(&one, &y, 1, &output, 1, N)
    return output
}

func tan(x:[Double]) -> [Double] {
    var N = Int32(x.count)
    var y = [Double](count: x.count, repeatedValue: 0.0)

    vvtan(&y, x, &N)
    return y
}

func tan(x:[Float]) -> [Float] {
    var N = Int32(x.count)
    var y = [Float](count: x.count, repeatedValue: 0.0)

    vvtanf(&y, x, &N)
    return y
}

func cot(x:[Double]) -> [Double]{
    var y = tan(x)
    var output = [Double](count:y.count, repeatedValue:0.0)
    var one = 1.0
    let N = vDSP_Length(y.count)

    vDSP_svdivD(&one, &y, 1, &output, 1, N)
    return output
}

func cot(x:[Float]) -> [Float]{
    var y = tan(x)
    var output = [Float](count:y.count, repeatedValue:0.0)
    var one:Float = 1.0
    let N = vDSP_Length(y.count)

    vDSP_svdiv(&one, &y, 1, &output, 1, N)
    return output
}
