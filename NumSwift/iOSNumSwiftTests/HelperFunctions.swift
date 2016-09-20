//
//  Created by DboyLiao on 4/1/16.
//  Copyright © 2016 DboyLiao. All rights reserved.
//

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

func getShorterString<T:Equatable>(_ x:[T]) -> String {
    
    var result:String
    
    if x.count < 20 {
        
        result = String(describing: x)
        
    } else {
        result = "["
        for i in 0..<5 {
            result += (String(describing: x[i]) + ", ")
        }
        result += "..., "
        
        for i in 0..<4 {
            result += (String(describing: x[x.count-5+i]) + ", ")
        }
        result += (String(describing: x[x.count-1]) + "]")
    }
    
    return result
}

func colorPrint(_ args:AnyObject..., color:String) {
    
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

func testAllClose(_ x:[Double], _ y:[Double], tol:Double = 3e-7) -> (Bool, Double) {
    
    /*
     Return `true` if x and y are element-wise equal within a tolerance.
     
     params:
     `x`, `y`: double-precision array.
     `tol`: tolerance.
     */
    
    var inputX = [Double](x)
    var inputY = [Double](y)
    var isClosed = false
    var maximum:Double = 0.0
    
    if x.count == y.count {
        
        let N = x.count
        
        var xMinusY = [Double](repeating: 0.0, count: N)
        
        // Compute x - y (vectorized)
        vDSP_vsubD(&inputX, 1, &inputY, 1, &xMinusY, 1, vDSP_Length(N))
        
        // Take abs value
        vDSP_vabsD(&xMinusY, 1, &xMinusY, 1, vDSP_Length(N))
        
        vDSP_maxvD(&xMinusY, 1, &maximum, vDSP_Length(N))
        
        if maximum <= tol {
            isClosed = true
        }
    }
    
    return (isClosed, maximum)
    
}

func testAllClose(_ x:[Float], _ y:[Float], tol:Float = 3e-7) -> (Bool, Float) {
    
    /*
     Return `true` if x and y are element-wise equal within a tolerance.
     
     params:
     `x`, `y`: double-precision array.
     `tol`: tolerance.
     */
    
    var inputX = [Float](x)
    var inputY = [Float](y)
    var isClosed = false
    var maximum:Float = 0.0
    
    if x.count == y.count {
        
        let N = x.count
        
        var xMinusY = [Float](repeating: 0.0, count: N)
        
        // Compute x - y (vectorized)
        vDSP_vsub(&inputX, 1, &inputY, 1, &xMinusY, 1, vDSP_Length(N))
        
        // Take abs value
        vDSP_vabs(&xMinusY, 1, &xMinusY, 1, vDSP_Length(N))
        
        vDSP_maxv(&xMinusY, 1, &maximum, vDSP_Length(N))
        
        if maximum <= tol {
            isClosed = true
        }
    }
    
    return (isClosed, maximum)
    
}
