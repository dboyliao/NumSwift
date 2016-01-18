import Accelerate

func arangeD(N:Int, start:Int = 1) -> [Double]{

    var startDouble = Double(start)
    var one = Double(1)
    var result = [Double](count:N, repeatedValue:0.0)
    vDSP_vrampD(&startDouble, &one, &result, 1, vDSP_Length(N))

    return result
}

func arange(N:Int, start:Int = 1) -> [Float] {

    var startFloat = Float(start)
    var one = Float(1)
    var result = [Float](count:N, repeatedValue:0.0)
    vDSP_vramp(&startFloat, &one, &result, 1, vDSP_Length(N))

    return result
}

func linspace(start:Double, _ end:Double, num:Int) -> [Double]{

    var startDouble = Double(start)
    let endDouble = Double(end)
    var dx = (endDouble - startDouble)/Double(num-1)

    var result = [Double](count:num, repeatedValue:0.0)

    vDSP_vrampD(&startDouble, &dx, &result, 1, vDSP_Length(num))

    return result

}

func linspace(start:Float, _ end:Float, num:Int) -> [Float]{

    var startDouble = Float(start)
    let endDouble = Float(end)
    var dx = (endDouble - startDouble)/Float(num-1)

    var result = [Float](count:num, repeatedValue:0.0)

    vDSP_vramp(&startDouble, &dx, &result, 1, vDSP_Length(num))

    return result
}

func mean(x:[Double]) -> Double {

    let ptr_x = UnsafePointer<Double>(x)
    var value:Double = 0.0
    vDSP_meanvD(ptr_x, 1, &value, vDSP_Length(x.count))

    return value

}

func mean(x:[Float]) -> Float {

    let ptr_x = UnsafePointer<Float>(x)
    var value:Float = 0.0
    vDSP_meanv(ptr_x, 1, &value, vDSP_Length(x.count))

    return value
}

func splitArrayIntoParts(x:[Double], _ numberOfParts: Int) -> [[Double]] {

    var parts = [[Double]]()
    let input = [Double](x)
    let samplesPerSplit = Int(round(Double(x.count)/Double(numberOfParts)))

    var startIndex:Int
    var endIndex:Int
    var slice:ArraySlice<Double>
    for i in 1..<numberOfParts {
        startIndex = (i-1)*samplesPerSplit
        endIndex = i*samplesPerSplit
        slice = input[startIndex..<endIndex]
        parts.append([Double](slice))
    }

    startIndex = (numberOfParts-1)*samplesPerSplit
    endIndex = x.count
    slice = input[startIndex..<endIndex]
    parts.append([Double](slice))

    return parts

}

func splitArrayIntoParts(x:[Float], _ numberOfParts: Int) -> [[Float]] {

    var parts = [[Float]]()
    let input = [Float](x)
    let samplesPerSplit = Int(round(Double(x.count)/Double(numberOfParts)))

    var startIndex:Int
    var endIndex:Int
    var slice:ArraySlice<Float>
    for i in 1..<numberOfParts {
        startIndex = (i-1)*samplesPerSplit
        endIndex = i*samplesPerSplit
        slice = input[startIndex..<endIndex]
        parts.append([Float](slice))
    }

    startIndex = (numberOfParts-1)*samplesPerSplit
    endIndex = x.count
    slice = input[startIndex..<endIndex]
    parts.append([Float](slice))

    return parts

}

func leastPowerOfTwo(N:Int) -> Int {
    /*
    Find the least power of two greater than `N`.
    */ 

    let log2N = Int(log2(Double(N)))
    var NPowTwo = 1 << log2N

    if NPowTwo < N {
        NPowTwo = NPowTwo << 1
    }

    return NPowTwo
}

func abs(x:[Double]) -> [Double] {

    var input = [Double](x)
    var output = [Double](count:x.count, repeatedValue:0.0)

    vDSP_vabsD(&input, 1, &output, 1, vDSP_Length(x.count))

    return output
}

func abs(x:[Float]) -> [Float] {

    var input = [Float](x)
    var output = [Float](count:x.count, repeatedValue:0.0)

    vDSP_vabs(&input, 1, &output, 1, vDSP_Length(x.count))

    return output

}

func pad(x:[Double], value:Double = 0.0, toLength length: Int) -> [Double] {

    let result:[Double]

    if length <= x.count {
        result = [Double](x)
    } else {
        result = [Double](x) + [Double](count:length - x.count, repeatedValue:value)
    }
    return result
}

func pad(x:[Float], value:Float = 0.0, toLength length: Int) -> [Float] {

    let result:[Float]

    if length <= x.count {
        result = [Float](x)
    } else {
        result = [Float](x) + [Float](count:length - x.count, repeatedValue:value)
    }
    return result
}

func allClose(x:[Double], y:[Double], tol:Double = 3e-7) -> Bool {

    var inputX = [Double](x)
    var inputY = [Double](y)
    var isClosed = false

    if x.count == y.count {

        let N = x.count

        var xMinusY = [Double](count:N, repeatedValue:0.0)
        
        // Compute x - y (vectorized)
        vDSP_vsubD(&inputX, 1, &inputY, 1, &xMinusY, 1, vDSP_Length(N))

        // Take abs value
        vDSP_vabsD(&xMinusY, 1, &xMinusY, 1, vDSP_Length(N))

        var maximum:Double = 0
        vDSP_maxvD(&xMinusY, 1, &maximum, vDSP_Length(N))

        if maximum <= tol {
            isClosed = true
        }
    }

    return isClosed

}

func allClose(x:[Float], y:[Float], tol:Float = 3e-7) -> Bool {

    var inputX = [Float](x)
    var inputY = [Float](y)
    var isClosed = false

    if x.count == y.count {

        let N = x.count

        var xMinusY = [Float](count:N, repeatedValue:0.0)
        
        // Compute x - y (vectorized)
        vDSP_vsub(&inputX, 1, &inputY, 1, &xMinusY, 1, vDSP_Length(N))

        // Take abs value
        vDSP_vabs(&xMinusY, 1, &xMinusY, 1, vDSP_Length(N))

        var maximum:Float = 0
        vDSP_maxv(&xMinusY, 1, &maximum, vDSP_Length(N))

        if maximum <= tol {
            isClosed = true
        }
    }

    return isClosed
    
}