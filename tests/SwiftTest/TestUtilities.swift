import Foundation
import Accelerate

let ColorCodes = [
    "black": "1;30",
    "red": "1;31",
    "green": "1;32",
    "yellow": "1;33",
    "blue": "1;34",
    "magenta": "1;35",
    "cyan": "1;36",
    "white": "1;37" 
]

func getShorterString<T:Equatable>(x:[T]) -> String {

    var result:String

    if x.count < 20 {

        result = String(x)
        
    } else {
        result = "["
        for i in 0..<5 {
            result += (String(x[i]) + ", ")
        }
        result += "..., "

        for i in 0..<4 {
            result += (String(x[x.count-5+i]) + ", ")
        }
        result += (String(x[x.count-1]) + "]")
    }

    return result
}

func colorPrint(args:AnyObject..., color:String) {

    switch color {

        case "black", "red", "green", "yellow", "blue", "magenta", "cyan", "white":

            let colorCode = ColorCodes[color]!

            for arg in args {
                print("\u{001B}[\(colorCode)m\(arg)\u{001B}[0m")
            }

        default:
            for arg in args {
                print(arg)
            }
    }
}

func testAllClose(x:[Double], y:[Double], tol:Double = 3e-7) -> Bool {

    /*
    Return `true` if x and y are element-wise equal within a tolerance.

    params:
        `x`, `y`: double-precision array.
        `tol`: tolerance. 
    */

    var inputX = [Double](x)
    var inputY = [Double](y)
    var isClosed = false

    if x.count == y.count {

        let N = x.count

        var xMinusY = [Double](count:N, repeatedValue:0.0)
        
        // Compute x - y (vectorized)
        vDSP_vsubD(&inputX, 1, &inputY, 1, &xMinusY, 1, vDSP_Length(N))

        // Take abs value
        vDSP_vabsD(&xMinusY, 1, &xMinusY, 1, vDSP_Length(N))

        var maximum:Double = 0
        vDSP_maxvD(&xMinusY, 1, &maximum, vDSP_Length(N))

        if maximum <= tol {
            isClosed = true
        }
    }

    return isClosed

}

func testAllClose(x:[Float], y:[Float], tol:Float = 3e-7) -> Bool {

    /*
    Return `true` if x and y are element-wise equal within a tolerance.

    params:
        `x`, `y`: double-precision array.
        `tol`: tolerance. 
    */

    var inputX = [Float](x)
    var inputY = [Float](y)
    var isClosed = false

    if x.count == y.count {

        let N = x.count

        var xMinusY = [Float](count:N, repeatedValue:0.0)
        
        // Compute x - y (vectorized)
        vDSP_vsub(&inputX, 1, &inputY, 1, &xMinusY, 1, vDSP_Length(N))

        // Take abs value
        vDSP_vabs(&xMinusY, 1, &xMinusY, 1, vDSP_Length(N))

        var maximum:Float = 0
        vDSP_maxv(&xMinusY, 1, &maximum, vDSP_Length(N))

        if maximum <= tol {
            isClosed = true
        }
    }

    return isClosed
    
}
