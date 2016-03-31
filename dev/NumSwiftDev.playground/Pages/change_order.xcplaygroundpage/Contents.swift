import Accelerate

let data:[Double] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
let rows = 4
let cols = 3

var newData = [Double](count:12, repeatedValue:0)
let ptrNew = UnsafeMutablePointer<Double>(newData)
let ptr = UnsafePointer<Double>(data)

// row-major to column major
for offset in 0..<cols {
    let start = UInt(offset)
    let end = UInt(data.count+1)
    let stride = start.dynamicType.Stride(cols)
    let index = [UInt]((start+1).stride(to:end, by:stride))
    ptr.advancedBy(offset)[0]
    ptrNew.advancedBy(offset)[0]
    vDSP_vgathrD(data, index, 1, ptrNew.advancedBy(rows*offset), 1, UInt(rows))
}

newData
