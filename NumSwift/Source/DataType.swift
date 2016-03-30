import Accelerate

public class Matrix<T:FloatingPointType> {
    typealias Element = T

    public let data:[T]
    public let rows:Int
    public let cols:Int
    private let _order:CBLAS_ORDER
    public var order:CBLAS_ORDER {
        self._order
    }
    public var size:(Int, Int) {
        return (rows, cols)
    }


    public init?(data:[T], rows:Int, cols:Int, order:CBLAS_ORDER = CblasRowMajor){

        if data.count != rows*cols {
            return nil
        }

        self.data = data
        self.rows = rows
        self.cols = cols
        self._order = order
        
    }

    public convenience init?(data:ArraySlice<T>, rows:Int, cols:Int, order:CBLAS_ORDER = CblasRowMajor){

        let array = Array<T>(data)
        
        self.init(data:array, rows: rows, cols: cols, order: order)

    }

    public init(matrix:Matrix<T>){
        self.data = matrix.data
        self.rows = matrix.rows
        self.cols = matrix.cols
        self._order = matrix.order
    }

    func setDataOrder(toOrder:CBLAS_ORDER){
        if self.order == order {
            return
        }

        var newData = [T](count:self.rows * self.cols, repeatedValue:T.self(0))

        switch (self.order, Element.self) {
        case (CblasRowMajor, is Double.Type): // convert to column major
            break
        case (CblasRowMajor, is Float.Type):
            break
        case (CblasColMajor, is Double.Type):
            break
        case (CblasColMajor, is Float.Type):
            break
        default:
            return 
        }
    }

    public class func zeros(rows:Int, _ cols:Int, order:CBLAS_ORDER = CblasRowMajor) -> Matrix<T> {
        return Matrix<T>(data:[T](count:rows*cols, repeatedValue:T.self(0)), rows:rows, cols:cols, order:order)!
    }

    // TODO: subscript methods.

    public subscript(indexX:Int, indexY:Int) -> T {
        let offset:Int
        switch self.order {
        case CblasRowMajor:
            offset = indexX * self.cols + indexY
        case CblasColMajor:
            offset = indexY * self.rows + indexX
        default:
            offset = 0
        }

        return self.data[offset]
    }

    // subscript(xRange:Range<Int>, yRange:Range<Int>) -> Matrix<T>{

    // }
}