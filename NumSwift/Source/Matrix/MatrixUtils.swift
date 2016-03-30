import Accelerate

public func mean(arrayOfMatrices:[[Double]]) -> [Double] {
    var result = [Double](count:arrayOfMatrices[0].count, repeatedValue:0)

    for index in 0..<arrayOfMatrices.count {

        result = try! add(result, arrayOfMatrices[index])

    }

    
    return [Double]()
}

public func mean(arrayOfMatrices:[[Float]]) -> [Float] {

    return [Float]()
}