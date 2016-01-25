import NumSwift

let xd = [1.0, -2.0, 3.0, -4.0]
let xf:[Float] = [1.0, -2.0, 3.0, -4.0]

let xd_abs = [1.0, 2.0, 3.0, 4.0]
let xf_abs:[Float] = [1, 2, 3, 4]

func testAbsDouble() -> [Double] {

    return abs(xd)

}

func testAbsFloat() -> [Float] {

    return abs(xf)

}

testEqual("Abs Test Double", test:testAbsDouble, expect:xd_abs)
testEqual("Abs Test Float", test:testAbsFloat, expect:xf_abs)