let a = Complex(real:1.0, imag:2.0)
let b = Complex(real:1.0, imag:2.0)
let c = a + b

func testRealPart() -> Double {

    return c.real

}

func testImagPart() -> Double {

    return c.imag
}

func main(){
    // Testing Complex number
    testEqual("Test Addition on Real Part", test:testRealPart, expect:2.0)
    testEqual("Test Addition on Imag Part", test:testImagPart, expect:4.0)

}

main()