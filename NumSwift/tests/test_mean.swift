import NumSwift

let xd:[Double] = [1.1, 2.5, 3.7, 2.9, 8.4, 8.8, 9]
let xf:[Float] = [1.1, 2.5, 3.7, 2.9, 8.4, 8.8, 9]

func testMeanDouble() -> [Double] {

    return [mean(xd)]

}

func testMeanFloat() -> [Float] {

    return [mean(xf)]

}

testEqualInTol("Test Compute Mean Double", test:testMeanDouble, expect:[5.2], tol:1e-15)
testEqualInTol("Test Compute Mean Float", test:testMeanFloat, expect:[5.2], tol:1e-6)
