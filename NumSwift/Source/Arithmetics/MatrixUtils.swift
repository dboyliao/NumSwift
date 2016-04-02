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
//

import Accelerate

public func mean<Element:Field>(of matrices:[Matrix<Element>]) -> Matrix<Element> {
    var meanMatrix = Matrix<Element>.Zeros(like: matrices[0])
    
    for index in 0..<matrices.count {
        meanMatrix = meanMatrix + matrices[index]
    }
    
    meanMatrix = meanMatrix * Element(1.0/Double(matrices.count))
    return meanMatrix
}

public func mean<Element:Field>(of matrix:Matrix<Element>) -> Element {
    
    var result = [Element(0)]
    
    switch matrix.dtype {
    case is Double.Type:
        let ptrResult = UnsafeMutablePointer<Double>(result)
        let ptrData = UnsafePointer<Double>(matrix.data)
        vDSP_meanvD(ptrData, 1, ptrResult, UInt(matrix.count))
    case is Float.Type:
        let ptrResult = UnsafeMutablePointer<Float>(result)
        let ptrData = UnsafePointer<Float>(matrix.data)
        vDSP_meanv(ptrData, 1, ptrResult, UInt(matrix.count))
    default:
        break
    }
    
    return result[0]
    
}

public func transpose<Element:Field>(matrix:Matrix<Element>) -> Matrix<Element> {
    
    let newData = [Element](count:matrix.count, repeatedValue:Element(0))
    
    switch matrix.dtype {
    case is Double.Type:
        let ptrData = UnsafePointer<Double>(matrix.data)
        let ptrNewData = UnsafeMutablePointer<Double>(newData)
        vDSP_mtransD(ptrData, 1, ptrNewData, 1, UInt(matrix.cols), UInt(matrix.rows))
    case is Float.Type:
        let ptrData = UnsafePointer<Float>(matrix.data)
        let ptrNewData = UnsafeMutablePointer<Float>(newData)
        vDSP_mtrans(ptrData, 1, ptrNewData, 1, UInt(matrix.cols), UInt(matrix.rows))
    default:
        break
    }
    
    return Matrix<Element>(data:newData, rows:matrix.cols, cols:matrix.rows)!
}

// TODO: implement other norm type.
public func norm<Element:Field>(matrix: Matrix<Element>, normType:MatrixNormType = .NormL2) -> Element {
    
    let matrixNorm:Element
    
    switch (matrix.dtype, normType) {
    case (is Double.Type, .NormL2):
        let ptrData = UnsafePointer<Double>(matrix.data)
        var dataSquare = [Double](count:matrix.count, repeatedValue:0)
        vDSP_vsqD(ptrData, 1, &dataSquare, 1, UInt(matrix.count))
        matrixNorm = Element(sqrt(dataSquare.reduce(0){ $0 + $1 }))
    case (is Float.Type, .NormL2):
        let ptrData = UnsafePointer<Float>(matrix.data)
        var dataSquare = [Float](count:matrix.count, repeatedValue:0)
        vDSP_vsq(ptrData, 1, &dataSquare, 1, UInt(matrix.count))
        matrixNorm = Element(sqrt(dataSquare.reduce(0){ $0 + $1 }))
    default:
        matrixNorm = Element(0)
    }
    
    return matrixNorm
}

// TODO: matrix inverse.
public func inv<Element:Field>(matrix:Matrix<Element>) -> Matrix<Element> {
    return Matrix<Element>.Zeros(2, 2)
}