#!/usr/bin/env swift
import Accelerate
import Foundation

let N = 100

// Sorting with Accelerate
func random() -> Float {

    return Float(arc4random())/Float(UINT32_MAX)

}

func random() -> Double {

    return Double(arc4random())/Double(UINT32_MAX)

}

var a = [Float](count: N, repeatedValue:0.0)
var b = [Float](count:N, repeatedValue:0.0)

for i in 0..<N{
    a[i] = random()
    b[i] = random()
}

// print("a:", a)
// print("b:", b)

var start = NSDate()
vDSP_vsort(&a, vDSP_Length(a.count), Int32(-1))
var end = NSDate()
print("[vDSP] duration: \(end.timeIntervalSinceDate(start))")

start = NSDate()
b.sortInPlace {
    return $0 > $1
}
end = NSDate()
print("[Basic] duration: \(end.timeIntervalSinceDate(start))")

func dev(x:[Float], y:[Float], tol:Float = 3e-7) -> Bool {

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
        print(xMinusY)
        print(maximum)

        if maximum <= tol {
            isClosed = true
        }
    }

    return isClosed
}

a = [1.0]
b = [1.0000001]

print(a, b)
print(dev(a, y:b))
// vDSP_vsort(&b, vDSP_Length(b.count), Int32(-1))
// print("a sorted:", a)
// print("b sorted:", b)
