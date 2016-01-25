import NumSwift

let xd:[Double] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let xf:[Float] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

func testNormalizeDouble() -> [Double]{

    return normalize(xd)
}

func testNormalizeFloat() -> [Float] {

    return normalize(xf)
}

let answerDouble:[Double] = [-1.5666989, -1.21854359, -0.87038828, -0.52223297, -0.17407766,
                             0.17407766,  0.52223297,  0.87038828,  1.21854359,  1.5666989]
let answerFloat:[Float] = [-1.5666989, -1.21854359, -0.87038828, -0.52223297, -0.17407766,
                             0.17407766,  0.52223297,  0.87038828,  1.21854359,  1.5666989]

testEqualInTol("Test Normalization Double", test:testNormalizeDouble, expect:answerDouble, tol:1e-8)
testEqualInTol("Test Normalization Float", test:testNormalizeFloat, expect:answerFloat, tol:1e-5)