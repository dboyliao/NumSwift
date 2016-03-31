import Accelerate

public func +<Element:Field>(left:Matrix<Element>, right:Matrix<Element>) -> Matrix<Element>{
    
    precondition(left.rows == right.rows && left.cols == right.cols, "The matrix dimensions do not match: \(left.size) and \(right.size)")
    precondition(left.order == right.order, "The data order do not match: \(left.order) and \(right.order)")
    precondition(left.dtype == right.dtype, "The matrices are of different data type: \(left.dtype) and \(right.dtype)")
    
    let newData = [Element](count:left.rows * left.cols, repeatedValue:Element.self(0))
    
    switch (left.dtype, right.dtype) {
    case (is Double.Type, is Double.Type):
        let ptrNewData = UnsafeMutablePointer<Double>(newData)
        let ptrLeftData = UnsafePointer<Double>(left.data)
        let ptrRightData = UnsafePointer<Double>(right.data)
        vDSP_vaddD(ptrLeftData, 1, ptrRightData, 1, ptrNewData, 1, UInt(left.count))
        
    case (is Float.Type, is Float.Type):
        let ptrNewData = UnsafeMutablePointer<Float>(newData)
        let ptrLeftData = UnsafePointer<Float>(left.data)
        let ptrRightData = UnsafePointer<Float>(right.data)
        vDSP_vadd(ptrLeftData, 1, ptrRightData, 1, ptrNewData, 1, UInt(left.count))
    default:
        break
    }
    
    return Matrix<Element>(data:newData, rows:left.rows, cols:left.cols, order:left.order)!
}

public func -<Element:Field>(left:Matrix<Element>, right:Matrix<Element>) -> Matrix<Element> {
    precondition(left.rows == right.rows && left.cols == right.cols, "The matrix dimensions do not match: \(left.size) and \(right.size)")
    precondition(left.order == right.order, "The data order do not match: \(left.order) and \(right.order)")
    precondition(left.dtype == right.dtype, "The matrices are of different data type: \(left.dtype) and \(right.dtype)")
    
    let newData = [Element](count:left.count, repeatedValue:Element.self(0))
    
    switch (left.dtype, right.dtype){
    case (is Double.Type, is Double.Type):
        let ptrNewData = UnsafeMutablePointer<Double>(newData)
        let ptrLeftData = UnsafePointer<Double>(left.data)
        let ptrRightData = UnsafePointer<Double>(right.data)
        
        vDSP_vsubD(ptrRightData, 1, ptrLeftData, 1, ptrNewData, 1, UInt(left.count))
        
    case (is Float.Type, is Float.Type):
        let ptrNewData = UnsafeMutablePointer<Float>(newData)
        let ptrLeftData = UnsafePointer<Float>(left.data)
        let ptrRightData = UnsafePointer<Float>(right.data)
        
        vDSP_vsub(ptrRightData, 1, ptrLeftData, 1, ptrNewData, 1, UInt(left.count))
            
    default:
        break
    }
    
    return Matrix<Element>(data:newData, rows:left.rows, cols:left.cols, order:left.order)!
}

public func *<Element:Field>(left:Matrix<Element>, right:Matrix<Element>) -> Matrix<Element> {
    precondition(left.cols == right.rows, "The matrix dimensions do not match: \(left.size) and \(right.size)")
    precondition(left.order == right.order, "The data order do not match: \(left.order) and \(right.order)")
    precondition(left.dtype == right.dtype, "The matrices are of different data type: \(left.dtype) and \(right.dtype)")
    
    let m = left.rows
    let n = right.cols
    let k = left.cols
    let newData = [Element](count:m * n, repeatedValue:Element.self(0))
    
    switch (left.dtype, right.dtype){
    case (is Double.Type, is Double.Type):
        let ptrNewData = UnsafeMutablePointer<Double>(newData)
        let ptrLeftData = UnsafePointer<Double>(left.data)
        let ptrRightData = UnsafePointer<Double>(right.data)
        cblas_dgemm(left.order, CblasNoTrans, CblasNoTrans, Int32(m), Int32(n), Int32(k), 1, ptrLeftData, Int32(k), ptrRightData, Int32(n), 1, ptrNewData, Int32(n))
    case (is Float.Type, is Float.Type):
        let ptrNewData = UnsafeMutablePointer<Float>(newData)
        let ptrLeftData = UnsafePointer<Float>(left.data)
        let ptrRightData = UnsafePointer<Float>(right.data)
        cblas_sgemm(left.order, CblasNoTrans, CblasNoTrans, Int32(m), Int32(n), Int32(k), 1, ptrLeftData, Int32(k), ptrRightData, Int32(n), 1, ptrNewData, Int32(n))
    default:
        break
    }
    
    return Matrix<Element>(data:newData, rows:m, cols:n, order:left.order)!
    
}

public func *<Element:Field>(left:Matrix<Element>, scalar:Element) -> Matrix<Element> {
    
    precondition(left.dtype == scalar.dynamicType.self, "The matrix and scalar of of different data type.")
    
    let newData = [Element](count:left.count, repeatedValue:Element.self(0))
    
    switch (left.dtype) {
    case is Double.Type:
        let ptrNewData = UnsafeMutablePointer<Double>(newData)
        let ptrLeftData = UnsafePointer<Double>(left.data)
        let ptrScalar = UnsafePointer<Double>([scalar])
        
        vDSP_vsmulD(ptrLeftData, 1, ptrScalar, ptrNewData, 1, UInt(left.count))
        
    case is Float.Type:
        let ptrNewData = UnsafeMutablePointer<Float>(newData)
        let ptrLeftData = UnsafePointer<Float>(left.data)
        let ptrScalar = UnsafePointer<Float>([scalar])
        
        vDSP_vsmul(ptrLeftData, 1, ptrScalar, ptrNewData, 1, UInt(left.count))
        
    default:
        break
    }
    
    return Matrix<Element>(data:newData, rows: left.rows, cols:left.cols, order:left.order)!
}

public func ==<Element:Field>(left:Matrix<Element>, right:Matrix<Element>) -> Bool {
    
    return left.data == right.data && left.rows == right.rows && left.cols == right.cols && left.order == right.order

}



public func mul(matA:[Float], _ matB:[Float], _ m:Int32, _ n:Int32, _ k:Int32) -> [Float]{
    
    let ptrMatA = UnsafeMutablePointer<Float>(matA)
    let ptrMatB = UnsafeMutablePointer<Float>(matB)
    var result = [Float](count:Int(m*n), repeatedValue:0)
    
    cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, m, n, k, 1, ptrMatA, k, ptrMatB, n, 1, &result, n)
    
    return result
}

public func mul(matA:[Double], _ matB:[Double], _ m:Int32, _ n:Int32, _ k:Int32) -> [Double]{
    
    let ptrMatA = UnsafeMutablePointer<Double>(matA)
    let ptrMatB = UnsafeMutablePointer<Double>(matB)
    var result = [Double](count:Int(m*n), repeatedValue:0)
    
    cblas_dgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans, m, n, k, 1, ptrMatA, k, ptrMatB, n, 1, &result, n)
    
    return result
}

public func mul(matA:[Double], _ matB:[Double]) throws -> [Double] {
    
    if matA.count != matB.count {
        throw MatrixError.LengthError
    }

    let ptrMatA = UnsafePointer<Double>(matA)
    let ptrMatB = UnsafePointer<Double>(matB)
    var result = [Double](count:matA.count, repeatedValue:0)

    vDSP_vmulD(ptrMatA, 1, ptrMatB, 1, &result, 1, UInt(matA.count))

    return result
}

public func mul(matA:[Float], _ matB:[Float]) throws -> [Float] {

    if matA.count != matB.count {
        throw MatrixError.LengthError
    }

    let ptrMatA = UnsafePointer<Float>(matA)
    let ptrMatB = UnsafePointer<Float>(matB)
    var result = [Float](count:matA.count, repeatedValue:0)

    vDSP_vmul(ptrMatA, 1, ptrMatB, 1, &result, 1, UInt(matA.count))

    return result
}

public func sub(matA:[Float], _ matB:[Float]) throws -> [Float] {
    
    if matA.count != matB.count {
        throw MatrixError.LengthError
    }
    
    let ptrMatA = UnsafeMutablePointer<Float>(matA)
    let ptrMatB = UnsafeMutablePointer<Float>(matB)
    var result = [Float](count:matA.count, repeatedValue:0)
    var one:Float = 1
    
    vDSP_vsmsb(ptrMatA, 1, &one, ptrMatB, 1, &result, 1, UInt(matA.count))
    
    return result
}

public func sub(matA:[Double], _ matB:[Double]) throws -> [Double]{
    
    if matA.count != matB.count {
        throw MatrixError.LengthError
    }
    
    let ptrMatA = UnsafeMutablePointer<Double>(matA)
    let ptrMatB = UnsafeMutablePointer<Double>(matB)
    var result = [Double](count:matA.count, repeatedValue:0)
    var one:Double = 1
    
    vDSP_vsmsbD(ptrMatA, 1, &one, ptrMatB, 1, &result, 1, UInt(matA.count))
    
    return result
}

public func sub(mat:[Double], _ scalar:Double) -> [Double] {
    
    let ptrMat = UnsafePointer<Double>(mat)
    var minusScalar:Double = -1*scalar
    var result = [Double](count:mat.count, repeatedValue:0)
    
    vDSP_vsaddD(ptrMat, 1, &minusScalar, &result, 1, UInt(mat.count))
    
    return result
}

public func sub(mat:[Float], _ scalar:Float) -> [Float] {
    
    let ptrMat = UnsafePointer<Float>(mat)
    var minusScalar:Float = -1*scalar
    var result = [Float](count:mat.count, repeatedValue:0)
    
    vDSP_vsadd(ptrMat, 1, &minusScalar, &result, 1, UInt(mat.count))
        
    return result
}

public func add(matA:[Float], _ matB:[Float]) throws -> [Float]{
    
    if matA.count != matB.count {
        throw MatrixError.LengthError
    }
    
    let ptrMatA = UnsafeMutablePointer<Float>(matA)
    let ptrMatB = UnsafeMutablePointer<Float>(matB)
    var result = [Float](count: matA.count, repeatedValue:0)
    
    vDSP_vadd(ptrMatA, 1, ptrMatB, 1, &result, 1, UInt(matA.count))
    
    return result
}

public func add(matA:[Double], _ matB:[Double]) throws -> [Double]{
    
    if matA.count != matB.count {
        throw MatrixError.LengthError
    }
    
    let ptrMatA = UnsafeMutablePointer<Double>(matA)
    let ptrMatB = UnsafeMutablePointer<Double>(matB)
    var result = [Double](count: matA.count, repeatedValue:0)
    
    vDSP_vaddD(ptrMatA, 1, ptrMatB, 1, &result, 1, UInt(matA.count))
    
    return result
}

public func add(mat:[Double], _ scalar:Double) -> [Double]{
    
    let ptrMat = UnsafePointer<Double>(mat)
    var scalar:Double = scalar
    var result = [Double](count:mat.count, repeatedValue:0)
    
    vDSP_vsaddD(ptrMat, 1, &scalar, &result, 1, UInt(mat.count))
    
    return result
}

public func add(mat:[Float], _ scalar:Float) -> [Float] {
    let ptrMat = UnsafePointer<Float>(mat)
    var scalar = scalar
    var result = [Float](count:mat.count, repeatedValue:0)
    
    vDSP_vsadd(ptrMat, 1, &scalar, &result, 1, UInt(mat.count))
    
    return result
}