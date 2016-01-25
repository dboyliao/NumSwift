import Accelerate

public func sort(x: [Double], order:Int) -> [Double]{

    /*
    Return sorted array in ascending or descending order.

    `params`:
        `x`: array to be sorted.
        `order`: 1 for ascending, -1 for descending
    */ 

    var input = [Double](x)

    vDSP_vsortD(&input, vDSP_Length(order), Int32(order))

    return input
}

public func sort(x: [Float], order:Int) -> [Float]{

    /*
    Return sorted array ascending or descending order.

    `params`:
        `x`: array to be sorted.
        `order`: 1 for ascending, -1 for descending
    */ 

    var input = [Float](x)

    vDSP_vsort(&input, vDSP_Length(order), Int32(order))

    return input
}