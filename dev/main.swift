import Accelerate

let realp:[Float] = [1, 2, 3, 4]
let imagp:[Float] = [1, 2, 3, 4]
let ptr_realp = UnsafeMutablePointer<Float>(realp)
let ptr_imagp = UnsafeMutablePointer<Float>(imagp)
let c1 = DSPSplitComplex(realp:ptr_realp, imagp:ptr_imagp)
let c2 = DSPSplitComplex(realp:ptr_realp, imagp:ptr_imagp)
let ptr_c1 = UnsafePointer<DSPSplitComplex>([c1])
let ptr_c2 = UnsafePointer<DSPSplitComplex>([c2])

var rrealp:[Float] = [0, 0, 0, 0]
var rimagp:[Float] = [0, 0, 0, 0]
let ptr_rrealp = UnsafeMutablePointer<Float>(rrealp)
let ptr_rimagp = UnsafeMutablePointer<Float>(rimagp)
let r = DSPSplitComplex(realp:ptr_rrealp, imagp:ptr_rimagp)
let ptr_r = UnsafePointer<DSPSplitComplex>([r])

vDSP_zvmul(ptr_c1, 1, ptr_c2, 1, ptr_r, 1, vDSP_Length(4), Int32(1))

for i in 0..<4 {
    print(rrealp[i], rimagp[i])
}