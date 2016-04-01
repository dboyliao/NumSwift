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

public func +<Element:Field>(left:Matrix<Element>, scalar:Element) -> Matrix<Element> {
    
    let newData = [Element](count:left.count, repeatedValue:Element(0))
    switch (left.dtype) {
    case is Double.Type:
        let ptrNewData = UnsafeMutablePointer<Double>(newData)
        let ptrLeftData = UnsafePointer<Double>(left.data)
        let ptrScalar = UnsafePointer<Double>([scalar])
        vDSP_vsaddD(ptrLeftData, 1, ptrScalar, ptrNewData, 1, UInt(left.count))
    case is Float.Type:
        let ptrNewData = UnsafeMutablePointer<Float>(newData)
        let ptrLeftData = UnsafePointer<Float>(left.data)
        let ptrScalar = UnsafePointer<Float>([scalar])
        vDSP_vsadd(ptrLeftData, 1, ptrScalar, ptrNewData, 1, UInt(left.count))
    default:
        break
    }
    
    return Matrix<Element>(data:newData, rows:left.rows, cols:left.cols, order:left.order)!
}

public func +<Element:Field>(scalar:Element, right:Matrix<Element>) -> Matrix<Element> {
    
    let result = right + scalar
    
    return result
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

public func -<Element:Field>(left:Matrix<Element>, scalar:Element) -> Matrix<Element> {
    
    let newData = [Element](count:left.count, repeatedValue:Element(0))
    switch (left.dtype) {
    case is Double.Type:
        let ptrNewData = UnsafeMutablePointer<Double>(newData)
        let ptrLeftData = UnsafePointer<Double>(left.data)
        let scalarCasted = scalar as! Double
        let ptrScalar = UnsafePointer<Double>([-1*scalarCasted])
        vDSP_vsaddD(ptrLeftData, 1, ptrScalar, ptrNewData, 1, UInt(left.count))
    case is Float.Type:
        let ptrNewData = UnsafeMutablePointer<Float>(newData)
        let ptrLeftData = UnsafePointer<Float>(left.data)
        let scalarCasted = scalar as! Float
        let ptrScalar = UnsafePointer<Float>([-1*scalarCasted])
        vDSP_vsadd(ptrLeftData, 1, ptrScalar, ptrNewData, 1, UInt(left.count))
    default:
        break
    }
    
    return Matrix<Element>(data:newData, rows:left.rows, cols:left.cols, order:left.order)!
}

public func -<Element:Field>(scalar:Element, right:Matrix<Element>) -> Matrix<Element> {
    
    let newData = [Element](count:right.count, repeatedValue:Element(0))
    
    switch (right.dtype) {
    case is Double.Type:
        let scalarCasted = -1*(scalar as! Double)
        let minusOne:Double = -1
        let mPtrNewData = UnsafeMutablePointer<Double>(newData)
        let ptrRightData = UnsafePointer<Double>(right.data)
        
        vDSP_vsaddD(ptrRightData, 1, [scalarCasted], mPtrNewData, 1, UInt(right.count))
        
        let ptrNewData = UnsafePointer<Double>(newData)
        vDSP_vsmulD(ptrNewData, 1, [minusOne], mPtrNewData, 1, UInt(right.count))
    case is Float.Type:
        let scalarCasted = -1*(scalar as! Float)
        let minusOne:Float = -1
        let mPtrNewData = UnsafeMutablePointer<Float>(newData)
        let ptrRightData = UnsafePointer<Float>(right.data)
        
        vDSP_vsadd(ptrRightData, 1, [scalarCasted], mPtrNewData, 1, UInt(right.count))
        
        let ptrNewData = UnsafePointer<Float>(newData)
        vDSP_vsmul(ptrNewData, 1, [minusOne], mPtrNewData, 1, UInt(right.count))
    default:
        break
    }
    
    return Matrix<Element>(data:newData, rows:right.rows, cols:right.cols, order:right.order)!
    
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

public func *<Element:Field>(scalar:Element, right:Matrix<Element>) -> Matrix<Element> {
    return right * scalar
}

public func ==<Element:Field>(left:Matrix<Element>, right:Matrix<Element>) -> Bool {
    
    return left.data == right.data && left.rows == right.rows && left.cols == right.cols && left.order == right.order

}
