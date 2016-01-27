import Foundation
import NumSwift

// Arrays
let N = 5
var xf = [Float](count:N, repeatedValue:0.0)
var xd = [Double](count:N, repeatedValue:0.0)

for i in 0..<N{
    xf[i] = Float(M_PI)*Float(i+1)/Float(N)
    xd[i] = M_PI*Double(i+1)/Double(N)
}

func generateAnswer(fun:(Float) -> Float, count: Int) -> [Float]{

    var answer = [Float](count: count, repeatedValue:0.0)

    for i in 0..<count {
        answer[i] = fun(xf[i])
    }

    return answer
}

func generateAnswerD(fun:(Double) -> Double, count: Int) -> [Double]{

    var answer = [Double](count: count, repeatedValue:0.0)

    for i in 0..<count {
        answer[i] = fun(xd[i])
    }

    return answer
}

// cos
func testCos() -> [Float] {
    
    colorPrint("Input:", color:"green")
    print("xf: \(xf)")
    
    return cos(xf)
}

func testCosD() -> [Double] {
    
    colorPrint("Input:", color:"green")
    print("xd: \(xd)")

    return cos(xd)
}

let answerCos = generateAnswer(Foundation.cos, count:N)
let answerCosD = generateAnswerD(Foundation.cos, count:N)

testEqualInTol("Cosine Float", test: testCos, expect: answerCos, tol:1e-5)
testEqualInTol("Cosine Double", test: testCosD, expect: answerCosD, tol:1e-13)

// sin
func testSin() -> [Float] {
    
    colorPrint("Input:", color:"green")
    print("xf: \(xf)")
    
    return sin(xf)
}

func testSinD() -> [Double] {
    
    colorPrint("Input:", color:"green")
    print("xd: \(xd)")
    
    return sin(xd)
}


let answerSin = generateAnswer(Foundation.sin, count:N)
let answerSinD = generateAnswerD(Foundation.sin, count:N)

testEqualInTol("Sin Float", test: testSin, expect: answerSin, tol:1e-5)
testEqualInTol("Sin Double", test: testSinD, expect: answerSinD, tol:1e-13)

// sec
func sec(x:Float) -> Float {
    return Float(1) / Foundation.cos(x)
}

func sec(x:Double) -> Double {
    return 1.0 / Foundation.cos(x)
}

func testSec() -> [Float] {
    
    colorPrint("Input:", color:"green")
    print("xf: \(xf)")
    
    return sec(xf)
}

func testSecD() -> [Double] {
    
    colorPrint("Input:", color:"green")
    print("xd: \(xd)")
    
    return sec(xd)
}

let answerSec = generateAnswer(sec, count:N)
let answerSecD = generateAnswerD(sec, count:N)

testEqualInTol("Secant Float", test: testSec, expect: answerSec, tol:1e-5)
testEqualInTol("Secant Double", test: testSecD, expect: answerSecD, tol:1e-13)

// csc
func csc(x:Float) -> Float {
    return Float(1) / Foundation.sin(x)
}

func csc(x:Double) -> Double {
    return 1.0 / Foundation.sin(x)
}

func testCsc() -> [Float] {
    colorPrint("Input:", color:"green")
    print("xf: \(xf)")

    return csc(xf)
}

func testCscD() -> [Double] {

    colorPrint("Input:", color:"green")
    print("xd: \(xd)")

    return csc(xd)
}

let answerCsc = generateAnswer(csc, count:N)
let answerCscD = generateAnswerD(csc, count:N)

testEqualInTol("Cosecant Float", test:testCsc, expect:answerCsc, tol:1e-5)
testEqualInTol("Cosecant Double", test:testCscD, expect:answerCscD, tol:1e-13)

// tan
func testTan() -> [Float] {
    colorPrint("Input:", color:"green")
    print("xf: \(xf)")

    return tan(xf)
}

func testTanD() -> [Double] {

    colorPrint("Input:", color:"green")
    print("xd: \(xd)")

    return tan(xd)
}

let answerTan = generateAnswer(Foundation.tan, count:N)
let answerTanD = generateAnswerD(Foundation.tan, count:N)

testEqualInTol("Tangent Float", test:testTan, expect:answerTan, tol:1e-5)
testEqualInTol("Tangent Double", test:testTanD, expect:answerTanD, tol:1e-13)

// cot
func testCot() -> [Float] {

    colorPrint("Input:", color:"green")
    print("xf: \(xf)")

    return cot(xf)
}

func testCotD() -> [Double] {

    colorPrint("Input:", color:"green")
    print("xd: \(xd)")

    return cot(xd)
}

func cot(x:Float) -> Float {
    return Float(1) / Foundation.tan(x)
}

func cot(x:Double) -> Double {
    return Double(1) / Foundation.tan(x)
}

let answerCot = generateAnswer(cot, count:N)
let answerCotD = generateAnswerD(cot, count:N)

testEqualInTol("Test Cotangent Float", test:testCot, expect:answerCot, tol:1e-5)
testEqualInTol("Test Cotangent Double", test:testCotD, expect:answerCotD, tol:1e-13)
