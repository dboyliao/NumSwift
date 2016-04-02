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

extension Matrix:Equatable {}

public class Matrix<Element:Field> {

    // public properties
    public var data:[Element] {
        return self._data
    }
    public let rows:Int
    public let cols:Int
    public var order:CBLAS_ORDER {
        return self._order
    }
    public var size:(Int, Int) {
        return (rows, cols)
    }
    public var dtype: Element.Type {
        return _dtype
    }
    public var count: Int {
        return self.data.count
    }

    // private properties
    private var _order:CBLAS_ORDER
    private var _data:[Element]
    private var _dtype = Element.self
    

    
    public init?(data:[Element], rows:Int, cols:Int, order:CBLAS_ORDER = CblasRowMajor){

        if data.count != rows*cols {
            return nil
        }

        self.rows = rows
        self.cols = cols
        self._data = data
        self._order = order
        
    }

    public convenience init?(data:ArraySlice<Element>, rows:Int, cols:Int, order:CBLAS_ORDER = CblasRowMajor){

        let array = Array<Element>(data)
        
        self.init(data:array, rows: rows, cols: cols, order: order)

    }

    public init(_ matrix:Matrix<Element>){
        self.rows = matrix.rows
        self.cols = matrix.cols
        self._order = matrix.order
        self._data = matrix.data
    }

    public func setDataOrder(toOrder order:CBLAS_ORDER){
        if self.order == order {
            return
        }

        let newData = [Element](count:self.rows * self.cols, repeatedValue:Element.self(0))

        switch (self.order, Element.self) {
        case (CblasRowMajor, is Double.Type): // convert to column major
            let stride = UInt.Stride(self.cols)
            let ptrData = UnsafePointer<Double>(self.data)
            let ptrNewData = UnsafeMutablePointer<Double>(newData)

            for offset in 0..<self.cols {
                let start = UInt(offset+1)
                let end = UInt(self.data.count + 1)
                let index = [UInt](start.stride(to:end, by:stride))
                vDSP_vgathrD(ptrData, index, 1, ptrNewData.advancedBy(offset * self.cols), 1, UInt(self.rows))
            }
        case (CblasRowMajor, is Float.Type):
            let stride = UInt.Stride(self.cols)
            let ptrData = UnsafePointer<Float>(data)
            let ptrNewData = UnsafeMutablePointer<Float>(newData)

            for offset in 0..<self.cols {
                let start = UInt(offset+1)
                let end = UInt(self.data.count + 1)
                let index = [UInt](start.stride(to:end, by:stride))
                vDSP_vgathr(ptrData, index, 1, ptrNewData.advancedBy(offset * self.cols), 1, UInt(self.rows))
            }
        case (CblasColMajor, is Double.Type):
            let stride = UInt.Stride(self.rows)
            let ptrData = UnsafePointer<Double>(data)
            let ptrNewData = UnsafeMutablePointer<Double>(newData)

            for offset in 0..<self.rows {
                let start = UInt(offset+1)
                let end = UInt(self.data.count + 1)
                let index = [UInt](start.stride(to:end, by:stride))
                vDSP_vgathrD(ptrData, index, 1, ptrNewData.advancedBy(offset * self.rows), 1, UInt(self.cols))
            }
        case (CblasColMajor, is Float.Type):
            let stride = UInt.Stride(self.rows)
            let ptrData = UnsafePointer<Float>(data)
            let ptrNewData = UnsafeMutablePointer<Float>(newData)

            for offset in 0..<self.rows {
                let start = UInt(offset+1)
                let end = UInt(self.data.count + 1)
                let index = [UInt](start.stride(to:end, by:stride))
                vDSP_vgathr(ptrData, index, 1, ptrNewData.advancedBy(offset * self.rows), 1, UInt(self.cols))
            }
        default:
            return 
        }
        self._order = order
        self._data = newData
    }

    public class func Zeros<Element>(rows:Int, _ cols:Int, order:CBLAS_ORDER = CblasRowMajor) -> Matrix<Element> {
        return Matrix<Element>(data:[Element](count:rows*cols, repeatedValue:Element.self(0)), rows:rows, cols:cols, order:order)!
    }

    public class func Zeros<Element>(like matrix: Matrix<Element>) -> Matrix<Element>{
        return Matrix<Element>.Zeros(matrix.rows, matrix.cols, order:matrix.order)
    }

    // TODO: subscript methods.
    public subscript(indexX:Int, indexY:Int) -> Element {
        let offset:Int
        switch self.order {
        case CblasRowMajor:
            offset = indexX * self.cols + indexY
        case CblasColMajor:
            offset = indexY * self.rows + indexX
        default:
            print("[Matrix subscription:indexX:indexY]: no such order")
            offset = 0
            break
        }

        return self.data[offset]
    }
    
    /*
    public subscript(rangeX:Range<Int>, rangeY:Range<Int>) -> Matrix<Element> {
        return Matrix<Element>.Zeros(2, 2)
    }
    */
    
    // TODO: type convertion
    // public func astype(type:Element.Type) -> Matrix<Element>
}