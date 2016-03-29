import NumSwift

let matAd:[Double] = [1, 2, 3, 4, 5, 6]
let matBd:[Double] = [6, 5, 4, 3, 2, 1]
let matAf:[Float] = [1, 2, 3, 4, 5, 6]
let matBf:[Float] = [6, 5, 4, 3, 2, 1]

func testMultiplicationDouble() -> [Double]{

    return mul(matAd, matBd, 3, 3, 2)
}

func testMultiplicationFloat() -> [Float]{
    return mul(matAf, matBf, 3, 3, 2)
}

var answerD:[Double] = [12,  9,  6, 30, 23, 16, 48, 37, 26]
var answerF:[Float] = [12,  9,  6, 30, 23, 16, 48, 37, 26]

testEqual("Matrix Multiplication: Double", test:testMultiplicationDouble, expect:answerD)
testEqual("Matrix Multiplication: Float", test:testMultiplicationFloat, expect:answerF)

func testMatrixAddDouble() -> [Double] {
    let result:[Double]
    
    do {
        result = try add(matAd, matBd)
    } catch {
        result = [Double]()
    }

    return result
}

func testMatrixAddFloat() -> [Float]{

    let result:[Float]
    do {
        result = try add(matAf, matBf)
    } catch {
        result = [Float]()
    }
    return result
}

answerD = [7, 7, 7, 7, 7, 7]
answerF = [7, 7, 7, 7, 7, 7]

testEqual("Matrix Add: Double", test: testMatrixAddDouble, expect:answerD)
testEqual("Matrix Add: Float", test: testMatrixAddFloat, expect: answerF)

func testMatrixAddScalarDouble() -> [Double] {

    return add(matAd, 1)
}

func testMatrixAddScalarFloat() -> [Float] {

    return add(matAf, 1)
}

answerD = [2, 3, 4, 5, 6, 7]
answerF = [2, 3, 4, 5, 6, 7]

testEqual("Matrix Add Scalar: Double", test: testMatrixAddScalarDouble, expect: answerD)
testEqual("Matrix Add Scalar: Float", test: testMatrixAddScalarFloat, expect: answerF)

func testMatrixSubtractDouble() -> [Double] {

    let result:[Double]
    do {
        result = try sub(matAd, matBd)
    } catch {
        result = [Double]()
    }
    return result
}

func testMatrixSubtractFloat() -> [Float] {

    let result:[Float]
    do {
        result = try sub(matAf, matBf)
    } catch {
        result = [Float]()
    }
    return result
}

answerD = [-5, -3, -1, 1, 3, 5]
answerF = [-5, -3, -1, 1, 3, 5]

testEqual("Matrix Subtract: Double", test: testMatrixSubtractDouble, expect: answerD)
testEqual("Matrix Subtract: Float", test: testMatrixSubtractFloat, expect: answerF)

func testMatrixSubtractScalarDouble() -> [Double] {

    return sub(matAd, 1)

}

func testMatrixSubtractScalarFloat() -> [Float] {

    return sub(matAf, 1)

}

answerD = [0, 1, 2, 3, 4, 5]
answerF = [0, 1, 2, 3, 4, 5]

testEqual("Matrix Subtract Scalar: Double", test: testMatrixSubtractScalarDouble, expect:answerD)
testEqual("Matrix subtract Scalar: Float", test: testMatrixSubtractScalarFloat, expect: answerF)