import NumSwift

let xf:[Float] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let xd:[Double] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

func testVarianceDouble() -> Double {

    return variance(xd)
}

func testVarianceFloat() -> Float {

    return variance(xf)
}

testEqual("Test Variance Double", test:testVarianceDouble, expect:8.25)
testEqual("Test Variance Float", test:testVarianceFloat, expect:8.25)

func testSTDDouble() -> Double {

    return std(xd)
}

func testSTDFloat() -> Float {

    return std(xf)
}

testEqual("Test Standard Deviation Double", test:testSTDDouble, expect:2.8722813232690143)
testEqual("Test Standard Deviation Float", test:testSTDFloat, expect:2.87228131)