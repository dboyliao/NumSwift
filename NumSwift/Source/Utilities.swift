import Accelerate
import Foundation

/**
 Compute Norm of 2D Vectors (Elementwise).
 
 - Parameters:
    - x: array of x-axis coordinates.
    - y: array of y-axis coordinates.
 
 - Returns: array of norm of each vector, (x_i, y_i), where x_i and y_i 
            are the i-th element of x and y, respectively.
*/
public func norm(x:[Double], _ y:[Double]) -> [Double]{

    var inputX = [Double](x)
    var inputY = [Double](y)
    var xSquare = [Double](count:x.count, repeatedValue:0.0)
    var ySquare = [Double](count:y.count, repeatedValue:0.0)

    vDSP_vsqD(&inputX, 1, &xSquare, 1, vDSP_Length(x.count))
    vDSP_vsqD(&inputY, 1, &ySquare, 1, vDSP_Length(y.count))

    var squareSum = [Double](count:x.count, repeatedValue:0.0)

    vDSP_vaddD(&xSquare, 1, &ySquare, 1, &squareSum, 1, vDSP_Length(x.count))

    var N = Int32(squareSum.count)
    var vectorNorm = [Double](count:squareSum.count, repeatedValue:0.0)
    vvsqrt(&vectorNorm, &squareSum, &N)

    return vectorNorm
}

/**
 Compute Norm of 2D Vectors (Elementwise).
 
 - Parameters:
    - x: array of x-axis coordinates.
    - y: array of y-axis coordinates.
 
 - Returns: array of norm of each vector, (x_i, y_i), where x_i and y_i
            are the i-th element of x and y, respectively.
*/
public func norm(x:[Float], _ y:[Float]) -> [Float]{
    
    var inputX = [Float](x)
    var inputY = [Float](y)
    var xSquare = [Float](count:x.count, repeatedValue:0.0)
    var ySquare = [Float](count:y.count, repeatedValue:0.0)

    vDSP_vsq(&inputX, 1, &xSquare, 1, vDSP_Length(x.count))
    vDSP_vsq(&inputY, 1, &ySquare, 1, vDSP_Length(y.count))

    var squareSum = [Float](count:x.count, repeatedValue:0.0)

    vDSP_vadd(&xSquare, 1, &ySquare, 1, &squareSum, 1, vDSP_Length(x.count))

    var N = Int32(squareSum.count)
    var vectorNorm = [Float](count:squareSum.count, repeatedValue:0.0)

    vvsqrtf(&vectorNorm, &squareSum, &N)

    return vectorNorm
}

/**
 Rounding toward Zero (Elementwise).
 
 - Parameters:
    - x: array to be rounded.
 
 - Returns: array of elements in x rounding toward zero.
 
 #### Example
 ```
 let x:[Double] = [1.1, 2.5, -1.2]
 
 roundToZero(x)
 // [1, 2, -1]
 ```
*/
public func roundToZero(x:[Double]) -> [Double]{

    var input = [Double](x)
    var fracPart = [Double](count:x.count, repeatedValue:0.0)
    vDSP_vfracD(&input, 1, &fracPart, 1, vDSP_Length(x.count))

    var result = [Double](count:x.count, repeatedValue:0.0)
    vDSP_vsubD(&fracPart, 1, &input, 1, &result, 1, vDSP_Length(x.count))

    return result

}

/**
 Rounding toward Zero (Elementwise).
 
 - Parameters:
    - x: array to be rounded.
 
 - Returns: array of elements in x rounding toward zero.
 
 #### Example
 ```
 let x:[Float] = [1.1, 2.5, -1.2]
 
 roundToZero(x)
 // [1, 2, -1]
 ```
*/
public func roundToZero(x:[Float]) -> [Float]{

    var input = [Float](x)
    var fracPart = [Float](count:x.count, repeatedValue:0.0)
    vDSP_vfrac(&input, 1, &fracPart, 1, vDSP_Length(x.count))

    var result = [Float](count:x.count, repeatedValue:0.0)
    vDSP_vsub(&fracPart, 1, &input, 1, &result, 1, vDSP_Length(x.count))

    return result

}

/**
 Evenly Spaced Values within a Given Interval.
 
 - Parameters:
    - N: output length
    - start: starting value (default 1).
    - step: step size between values.
 
 - Returns: A double precision array of sequential values starting at `start` 
            with even step size.
*/
public func arangeD(N:Int, start:Int = 1, step:Double = 1.0) -> [Double]{

    var startDouble = Double(start)
    var step = Double(step)
    var result = [Double](count:N, repeatedValue:0.0)
    vDSP_vrampD(&startDouble, &step, &result, 1, vDSP_Length(N))

    return result
}

/**
 Evenly Spaced Values within a Given Interval.
 
 - Parameters:
    - N: output length
    - start: starting value (default 1).
    - step: step size between values.
 
 - Returns: A single precision array of sequential values starting at `start` 
            with even step size.
*/
public func arange(N:Int, start:Int = 1, step:Float = 1.0) -> [Float] {

    var startFloat = Float(start)
    var step = step
    var result = [Float](count:N, repeatedValue:0.0)
    vDSP_vramp(&startFloat, &step, &result, 1, vDSP_Length(N))

    return result
}

/**
 Return evenly spaced numbers over a specified interval.
 
 - Parameters:
    - start: the value where the interval starts.
    - end: the value where the interval ends.
    - num: number of samples to be generated.
 
 - Returns: An double precision array of `num` many equally spaced samples.
*/
public func linspace(start:Double, _ end:Double, num:Int) -> [Double]{

    var startDouble = Double(start)
    var endDouble = Double(end)
    var result = [Double](count:num, repeatedValue:0.0)

    vDSP_vgenD(&startDouble, &endDouble, &result, 1, vDSP_Length(num))

    return result

}

/**
 Return evenly spaced numbers over a specified interval.
 
 - Parameters:
    - start: the value where the interval starts.
    - end: the value where the interval ends.
    - num: number of samples to be generated.
 
 - Returns: An single precision array of `num` many equally spaced samples.
*/
public func linspace(start:Float, _ end:Float, num:Int) -> [Float]{

    var startFloat = Float(start)
    var endFloat = Float(end)
    var result = [Float](count:num, repeatedValue:0.0)

    vDSP_vgen(&startFloat, &endFloat, &result, 1, vDSP_Length(num))

    return result
}

/**
 Compute the arithmetic mean
 
 - Parameters:
    - x: array of data
 
 - Returns: the mean of elements in x.
*/
public func mean(x:[Double]) -> Double {

    let ptr_x = UnsafePointer<Double>(x)
    var value:Double = 0.0
    vDSP_meanvD(ptr_x, 1, &value, vDSP_Length(x.count))

    return value

}

/**
 Compute the arithmetic mean
 
 - Parameters:
    - x: array of data
 
 - Returns: the mean of elements in x.
*/
public func mean(x:[Float]) -> Float {

    let ptr_x = UnsafePointer<Float>(x)
    var value:Float = 0.0
    vDSP_meanv(ptr_x, 1, &value, vDSP_Length(x.count))

    return value
}

/**
 Compute the variance
 
 - Note: variance = mean(abs(x - mean_x)^2)
 
 - Parameters:
    - x: array of data
 
 - Returns: the variance of elements in x.
 */
public func variance(x:[Double]) -> Double {

    let N = vDSP_Length(x.count)
    var output_buffer = [Double](count:x.count, repeatedValue:0.0)
    var neg_mean_x = -mean(x)

    vDSP_vsaddD(x, 1, &neg_mean_x, &output_buffer, 1, N)
    vDSP_vsqD(&output_buffer, 1, &output_buffer, 1, N)

    let result = output_buffer.reduce(0, combine:{$0 + $1})

    return result/Double(x.count)
}

/**
 Compute the variance
 
 - Note: variance = mean(abs(x - mean_x)^2)
 
 - Parameters:
    - x: array of data
 
 - Returns: the variance of elements in x.
*/
public func variance(x:[Float]) -> Float {

    let N = vDSP_Length(x.count)
    var output_buffer = [Float](count:x.count, repeatedValue:0.0)
    var neg_mean_x = -mean(x)

    vDSP_vsadd(x, 1, &neg_mean_x, &output_buffer, 1, N)
    vDSP_vsq(&output_buffer, 1, &output_buffer, 1, N)

    let result = output_buffer.reduce(0, combine:{$0 + $1})

    return result/Float(x.count)
}

/**
 Compute the standard deviation
 
 - Note: std = sqrt(variance(x))
 
 - Parameters:
    - x: the input data.
 
 - Returns: The standard deviation of x.
*/
public func std(x:[Double]) -> Double {

    return sqrt(variance(x))

}

/**
 Compute the standard deviation
 
 - Note: std = sqrt(variance(x))
 
 - Parameters:
    - x: the input data.
 
 - Returns: The standard deviation of x.
*/
public func std(x:[Float]) -> Float {

    return sqrt(variance(x))

}

/**
 Data normalization
 
 Normalize data to zero mean and unit standard deviation.
 
 - Parameters:
    - x: array of input data.
 
 - Returns: Normalized data which has zero mean and unit standard deviation.
*/
public func normalize(x:[Double]) -> [Double] {

    var mean_x = mean(x)
    var std_x = std(x)

    var x_normalized = [Double](count:x.count, repeatedValue:0.0)

    vDSP_normalizeD(x, 1, &x_normalized, 1, &mean_x, &std_x, vDSP_Length(x.count))

    return x_normalized

}

/**
 Data normalization
 
 Normalize data to zero mean and unit standard deviation.
 
 - Parameters:
    - x: array of input data.
 
 - Returns: Normalized data which has zero mean and unit standard deviation.
*/
public func normalize(x:[Float]) -> [Float]{

    var mean_x = mean(x)
    var std_x = std(x)

    var x_normalized = [Float](count:x.count, repeatedValue:0.0)

    vDSP_normalize(x, 1, &x_normalized, 1, &mean_x, &std_x, vDSP_Length(x.count))

    return x_normalized

}

/**
 Split array into smaller subarrays.
 
 - Parameters:
    - x: the input array.
    - numberOfParts: number of splits.
 
 - Returns: array of array of each split.
 
 #### Example
 ```
 let arr:[Double] = (1...6).map {Double($0)}
 
 splitArrayIntoParts(arr, 3)
 /// [[1, 2], [3, 4], [5, 6]]
 ```
*/
public func splitArrayIntoParts(x:[Double], _ numberOfParts: Int) -> [[Double]] {

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

/**
 Split array into smaller subarrays.
 
 - Parameters:
    - x: the input array.
    - numberOfParts: number of splits.
 
 - Returns: array of array of each split.
 
 #### Example
 ```
 let arr:[Double] = (1...6).map {Double($0)}
 
 splitArrayIntoParts(arr, 3)
 /// [[1, 2], [3, 4], [5, 6]]
 ```
 */
public func splitArrayIntoParts(x:[Float], _ numberOfParts: Int) -> [[Float]] {

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

/**
 Find the least power of 2.
 
 Returns the least power of 2 greater than `N`.
 
 - Parameters:
    - N: the lower bound of power of 2.
 
 - Returns: the least power of 2 greater than N
*/
public func leastPowerOfTwo(N:Int) -> Int {
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

/**
 Compute absolute value (elementwise).
 
 - Parameters:
    - x: the input data
 
 - Returns: an array containing the absolute value of each element in x.
*/
public func abs(x:[Double]) -> [Double] {

    var input = [Double](x)
    var output = [Double](count:x.count, repeatedValue:0.0)

    vDSP_vabsD(&input, 1, &output, 1, vDSP_Length(x.count))

    return output
}

/**
 Compute absolute value (elementwise).
 
 - Parameters:
    - x: the input data
 
 - Returns: an array containing the absolute value of each element in x.
*/
public func abs(x:[Float]) -> [Float] {

    var input = [Float](x)
    var output = [Float](count:x.count, repeatedValue:0.0)

    vDSP_vabs(&input, 1, &output, 1, vDSP_Length(x.count))

    return output

}

/**
 Padding array to specific length
 
 - Parameters:
    - x: the input array.
    - toLength: target length.
    - value: the number to be padded (default 0.0).
 
 - Returns: the padded array.
 
 #### Example
 ```
 let x:[Double] = [1, 2, 3]
 
 pad(x, toLength:5)
 /// [1.0, 2.0, 3.0, 0.0, 0.0]
 ```
*/
public func pad(x:[Double], toLength length: Int, value:Double = 0.0) -> [Double] {

    let result:[Double]

    if length <= x.count {
        result = [Double](x)
    } else {
        result = [Double](x) + [Double](count:length - x.count, repeatedValue:value)
    }
    return result
}

/**
 Padding array to specific length
 
 - Parameters:
    - x: the input array.
    - toLength: target length.
    - value: the number to be padded (default 0.0).
 
 - Returns: the padded array.
 
 #### Example
 ```
 let x:[Float] = [1, 2, 3]
 
 pad(x, toLength:5)
 /// [1.0, 2.0, 3.0, 0.0, 0.0]
 ```
 */
public func pad(x:[Float], toLength length: Int, value:Float = 0.0) -> [Float] {

    let result:[Float]

    if length <= x.count {
        result = [Float](x)
    } else {
        result = [Float](x) + [Float](count:length - x.count, repeatedValue:value)
    }
    return result
}

/**
 Return true if two arrays are equal with tolerance.
 
 - Parameters:
    - x: input array.
    - y: input array.
    - tol: tolerance.
 
 - Returns: true if two array are equal with tolerance, false otherwise.
*/
public func allClose(x:[Double], y:[Double], tol:Double = 3e-7) -> Bool {

    var inputX = [Double](x)
    var inputY = [Double](y)
    var isClosed = false

    if x.count == y.count {

        let N = x.count

        var xMinusY = [Double](count:N, repeatedValue:0.0)
        
        // Compute x - y (vectorized)
        vDSP_vsubD(&inputY, 1, &inputX, 1, &xMinusY, 1, vDSP_Length(N))

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

/**
 Return true if two arrays are equal with tolerance.
 
 - Parameters:
    - x: input array.
    - y: input array.
    - tol: tolerance.
 
 - Returns: true if two array are equal with tolerance, false otherwise.
*/
public func allClose(x:[Float], y:[Float], tol:Float = 3e-7) -> Bool {

    var inputX = [Float](x)
    var inputY = [Float](y)
    var isClosed = false

    if x.count == y.count {

        let N = x.count

        var xMinusY = [Float](count:N, repeatedValue:0.0)
        
        // Compute x - y (vectorized)
        vDSP_vsub(&inputY, 1, &inputX, 1, &xMinusY, 1, vDSP_Length(N))

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