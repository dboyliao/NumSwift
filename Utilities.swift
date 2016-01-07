import Accelerate

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