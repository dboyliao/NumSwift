import NumSwift

let xf:[Float] = [1, 2, 3, 4, 5, 6, 7, 8,
                  9, 10, 11, 12, 13, 14, 15, 16]

func testFloatHilbertReal() -> [Float] {
    let result = hilbert(xf)

    return result.realp
}

func testFloatHilbertImag() -> [Float] {
    let result = hilbert(xf)

    return result.imagp
}

let answerFloatRealp:[Float] = [1, 2, 3, 4, 5, 6, 7, 8,
                                9, 10, 11, 12, 13, 14, 15, 16]
let answerFloatImagp:[Float] = [11.21946338, 1.1647844, 1.1647844, -1.82842712,
                                -1.82842712, -3.1647844, -3.1647844, -3.56260914,
                                -3.56260914, -3.1647844, -3.1647844, -1.82842712,
                                -1.82842712, 1.1647844, 1.1647844, 11.21946338]

testEqualInTol("Float: Hilbert Realp", test:testFloatHilbertReal, 
               expect:answerFloatRealp, tol:1e-6)
testEqualInTol("Float: Hilbert Imagp", test:testFloatHilbertImag, 
               expect:answerFloatImagp, tol:1e-6)

let xd:[Double] = [1, 2, 3, 4, 5, 6, 7, 8,
                   9, 10, 11, 12, 13, 14, 15, 16]

func testDoubleHilbertReal() -> [Double] {
    let result = hilbert(xd)

    return result.realp
}

func testDoubleHilbertImag() -> [Double] {
    let result = hilbert(xd)

    return result.imagp
}

let answerDoubleRealp:[Double] = [1, 2, 3, 4, 5, 6, 7, 8,
                                9, 10, 11, 12, 13, 14, 15, 16]
let answerDoubleImagp:[Double] = [11.21946338, 1.1647844, 1.1647844, -1.82842712,
                                -1.82842712, -3.1647844, -3.1647844, -3.56260914,
                                -3.56260914, -3.1647844, -3.1647844, -1.82842712,
                                -1.82842712, 1.1647844, 1.1647844, 11.21946338]

testEqualInTol("Double: Hilbert Realp", test:testDoubleHilbertReal, 
               expect:answerDoubleRealp, tol:1e-7)
testEqualInTol("Double: Hilbert Imagp", test:testDoubleHilbertImag, 
               expect:answerDoubleImagp, tol:1e-7)
