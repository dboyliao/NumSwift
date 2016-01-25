import Accelerate
import NumSwift

colorPrint("===== tests on DSPComplex arithmetic====\n", color:"yellow")

var af = DSPComplex(real:1, imag:2)
var bf = DSPComplex(real:3, imag:4)

// norm

func testNormFloat() -> Float {
    return norm(bf)
}

// abs

func testAbsoluteFloat() -> Float {
    return abs(bf)
}

// +
func testPlusFloatReal() -> Float {

    let c = af + bf

    return c.real
}

func testPlusFloatImag() -> Float {

    let c = af + bf

    return c.imag
}

// -
func testMinusFloatReal() -> Float {

    let c = af - bf

    return c.real
}

func testMinusFloatImag() -> Float {

    let c = af - bf

    return c.imag
}

// *
func testMulFloatReal() -> Float {

    let c = af*bf

    return c.real
}

func testMulFloatImag() -> Float {

    let c = af*bf

    return c.imag
}

// /
func testDivFloatReal() -> Float {

    let c = af/bf

    return c.real
}

func testDivFloatImag() -> Float {
    let c = af/bf

    return c.imag
}

// Testing Complex number
testEqual("Float: Test Norm", test:testNormFloat, expect:25.0)
testEqual("Float: Test Absolute", test:testAbsoluteFloat, expect:5.0)

testEqual("Float: Test Addition on Real Part", test:testPlusFloatReal, expect:4.0)
testEqual("Float: Test Addition on Imag Part", test:testPlusFloatImag, expect:6.0)

testEqual("Float: Test Minus on Real Part", test:testMinusFloatReal, expect:-2.0)
testEqual("Float: Test Minus on Imag Part", test:testMinusFloatReal, expect:-2.0)

testEqual("Float: Test Multiplication on Real Part", test:testMulFloatReal, expect:-5.0)
testEqual("Float: Test Multiplication on Imag Part", test:testMulFloatImag, expect:10.0)

testEqual("Float: Test Division on Real Part", test:testDivFloatReal, expect:0.44)
testEqual("Float: Test Division on Imag Part", test:testDivFloatImag, expect:0.08)

colorPrint("===== tests on DSPDoubleComplex arithmetic====\n", color:"yellow")

let ad = DSPDoubleComplex(real:1, imag:2)
let bd = DSPDoubleComplex(real:3, imag:4)

// norm

func testNormDouble() -> Double {
    return norm(bd)
}

// abs

func testAbsoluteDouble() -> Double {
    return abs(bd)
}

func testPlusDoubleReal() -> Double {

    let c = ad + bd

    return c.real
}

func testPlusDoubleImag() -> Double {

    let c = ad + bd

    return c.imag
}

// -
func testMinusDoubleReal() -> Double {

    let c = ad - bd

    return c.real
}

func testMinusDoubleImag() -> Double {

    let c = ad - bd

    return c.imag
}

// *
func testMulDoubleReal() -> Double {

    let c = ad*bd

    return c.real
}

func testMulDoubleImag() -> Double {

    let c = ad*bd

    return c.imag
}

// /
func testDivDoubleReal() -> Double {

    let c = ad/bd

    return c.real
}

func testDivDoubleImag() -> Double {
    let c = ad/bd

    return c.imag
}

// Testing Complex number
testEqual("Double: Test Norm", test:testNormDouble, expect:25.0)
testEqual("Double: Test Absolute", test:testAbsoluteDouble, expect:5.0)

testEqual("Double: Test Addition on Real Part", test:testPlusDoubleReal, expect:4.0)
testEqual("Double: Test Addition on Imag Part", test:testPlusDoubleImag, expect:6.0)

testEqual("Double: Test Minus on Real Part", test:testMinusDoubleReal, expect:-2.0)
testEqual("Double: Test Minus on Imag Part", test:testMinusDoubleReal, expect:-2.0)

testEqual("Double: Test Multiplication on Real Part", test:testMulDoubleReal, expect:-5.0)
testEqual("Double: Test Multiplication on Imag Part", test:testMulDoubleImag, expect:10.0)

testEqual("Double: Test Division on Real Part", test:testDivDoubleReal, expect:0.44)
testEqual("Double: Test Division on Imag Part", test:testDivDoubleImag, expect:0.08)
