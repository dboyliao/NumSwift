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

// TODO: matrix inverse.
public func inv<Element:Field>(matrix:Matrix<Element>) -> Matrix<Element> {
    return Matrix<Element>.Zeros(2, 2)
}