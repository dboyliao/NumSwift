import NumSwift

let xd:[Double] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
let xf:[Float] = [1, 2, 3, 4, 5, 6, 7, 8, 9]

func testSqrtDouble() -> [Double] {

    colorPrint("Input: \(xd)", color:"yellow")

    return sqrt(xd)

}

func testSqrtFloat() -> [Float] {

    colorPrint("Input: \(xf)", color:"yellow")

    return sqrt(xf)
}

let answerDouble:[Double] = [1, 1.41421356, 1.73205081, 2, 2.23606798,
                             2.44948974, 2.64575131, 2.82842712, 3]

let answerFloat:[Float] = [1, 1.41421356, 1.73205081, 2, 2.23606798,
                           2.44948974, 2.64575131, 2.82842712, 3]

testEqualInTol("Test Square Root Double", test:testSqrtDouble, expect:answerDouble, tol:1e-8)
testEqualInTol("Test Square Root Float", test:testSqrtFloat, expect:answerFloat, tol:1e-8)