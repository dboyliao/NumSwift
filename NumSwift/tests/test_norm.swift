import NumSwift

let xd:[Double] = [1, 2, 3, 4, 5, 6, 7, 8]
let yd:[Double] = [8, 7, 6, 5, 4, 3, 2, 1]

func testNormDouble() -> [Double]{

    return norm(xd, yd)
}

let answerNormDouble:[Double] = [8.06225775, 7.28010989, 6.70820393, 6.40312424,
                                 6.40312424, 6.70820393, 7.28010989, 8.06225775]
testEqualInTol("Double: Test Norm Double", test:testNormDouble, expect:answerNormDouble, tol:1e-8)

let xf:[Float] = [1, 2, 3, 4, 5, 6, 7, 8]
let yf:[Float] = [8, 7, 6, 5, 4, 3, 2, 1]

func testNormFloat() -> [Float]{

    return norm(xf, yf)
}

let answerNormFloat:[Float] = [8.06225775, 7.28010989, 6.70820393, 6.40312424,
                               6.40312424, 6.70820393, 7.28010989, 8.06225775]

testEqualInTol("Float: Test Norm Float", test:testNormFloat, expect:answerNormFloat, tol:1e-8)