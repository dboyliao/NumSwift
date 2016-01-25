import NumSwift

colorPrint("======== Double Array Tests Start ========", color: "yellow")

func testDoubleSameLengthFullMode() -> [Double] {

    let xd:[Double] = [1, 2, 3, 4, 5]
    let yd:[Double] = [5, 4, 3, 2, 1]
    colorPrint("Inputs:", color:"green")
    print("xd: \(xd)")
    print("yd: \(yd)")

    return fft_convolve(xd, y:yd)

}

func testDoubleSameLengthSameMode() -> [Double] {

    let xd:[Double] = [1, 2, 3, 4, 5]
    let yd:[Double] = [5, 4, 3, 2, 1]
    colorPrint("Inputs:", color:"green")
    print("xd: \(xd)")
    print("yd: \(yd)")

    return fft_convolve(xd, y:yd, mode:"same")

}


func testDoubleSameLengthValidMode() -> [Double] {

    let xd:[Double] = [1, 2, 3, 4, 5]
    let yd:[Double] = [5, 4, 3, 2, 1]
    colorPrint("Inputs:", color:"green")
    print("xd: \(xd)")
    print("yd: \(yd)")

    return fft_convolve(xd, y:yd, mode:"valid")

}

let answerSameLengthFullD:[Double] = [5, 14, 26, 40, 55, 40, 26, 14, 5]
let answerSameLengthSameD:[Double] = [26, 40, 55, 40, 26]
let answerSameLengthValidD:[Double] = [55]

testEqualInTol("Double Same Length Array Full Mode", 
               test:testDoubleSameLengthFullMode, 
               expect:answerSameLengthFullD,
               tol:1e-13)

testEqualInTol("Double Same Length Array Same Mode",
          test:testDoubleSameLengthSameMode,
          expect:answerSameLengthSameD,
          tol:1e-13)

testEqualInTol("Double Same Length Array Valid Mode",
          test:testDoubleSameLengthValidMode,
          expect:answerSameLengthValidD,
          tol:1e-13)

func testDoubleDifferentLengthFullMode() -> [Double]{

    let xd:[Double] = [1, 2, 3]
    let yd:[Double] = [1, 2, 3, 4, 5, 6]

    colorPrint("Inputs:", color:"green")
    print("xd: \(xd)")
    print("yd: \(yd)")

    return fft_convolve(xd, y:yd)
}

func testDoubleDifferentLengthSameMode() -> [Double]{

    let xd:[Double] = [1, 2, 3]
    let yd:[Double] = [1, 2, 3, 4, 5, 6]

    colorPrint("Inputs:", color:"green")
    print("xd: \(xd)")
    print("yd: \(yd)")

    return fft_convolve(xd, y:yd, mode:"same")
}

func testDoubleDifferentLengthValidMode() -> [Double]{

    let xd:[Double] = [1, 2, 3]
    let yd:[Double] = [1, 2, 3, 4, 5, 6]

    colorPrint("Inputs:", color:"green")
    print("xd: \(xd)")
    print("yd: \(yd)")

    return fft_convolve(xd, y:yd, mode:"valid")
}

let answerDifferentLengthFullD:[Double] = [1, 4, 10, 16, 22, 28, 27, 18]
let answerDifferentLengthSameD:[Double] = [4, 10, 16, 22, 28, 27]
let answerDifferentLengthValidD:[Double] = [10, 16, 22, 28]

testEqualInTol("Double Different Length Array Full Mode",
          test: testDoubleDifferentLengthFullMode,
          expect: answerDifferentLengthFullD,
          tol:1e-13)

testEqualInTol("Double Different Length Array Same Mode",
          test: testDoubleDifferentLengthSameMode,
          expect: answerDifferentLengthSameD,
          tol:1e-13)

testEqualInTol("Double Different Length Array Valid Mode",
         test: testDoubleDifferentLengthValidMode,
         expect: answerDifferentLengthValidD,
         tol:1e-13)

func testSingleElementFullModeD() -> [Double] {

    let xd:[Double] = [1]
    let yd:[Double] = [5]

    colorPrint("Inputs:", color:"green")
    print("xd: \(xd)")
    print("yd: \(yd)")

    return fft_convolve(xd, y:yd)
}

func testSingleElementSameModeD() -> [Double] {

    let xd:[Double] = [1]
    let yd:[Double] = [5]

    colorPrint("Inputs:", color:"green")
    print("xd: \(xd)")
    print("yd: \(yd)")

    return fft_convolve(xd, y:yd, mode:"same")
}

func testSingleElementValidModeD() -> [Double] {

    let xd:[Double] = [1]
    let yd:[Double] = [5]

    colorPrint("Inputs:", color:"green")
    print("xd: \(xd)")
    print("yd: \(yd)")

    return fft_convolve(xd, y:yd, mode:"valid")
}

let answerSingleElementD:[Double] = [5]

testEqualInTol("Double Single Element Array Full Mode",
          test: testSingleElementFullModeD,
          expect: answerSingleElementD,
          tol:1e-13)

testEqualInTol("Double Single Element Array Same Mode",
          test: testSingleElementSameModeD,
          expect: answerSingleElementD,
          tol:1e-13)

testEqualInTol("Double Single Element Array Valid Mode",
          test: testSingleElementValidModeD,
          expect: answerSingleElementD,
          tol:1e-13)


func testDoubleBadMode() -> [Double] {

    let xd:[Double] = [1, 2, 3]
    let yd:[Double] = [1, 2]

    return fft_convolve(xd, y:yd, mode:"bad mode")
}

let answerBadModeDouble:[Double] = [1, 4, 7, 6]
testEqual("Double Bad Mode",
          test: testDoubleBadMode,
          expect: answerBadModeDouble)


func testFloatSameLengthFullMode() -> [Float] {

    let xf:[Float] = [1, 2, 3, 4, 5]
    let yf:[Float] = [5, 4, 3, 2, 1]

    colorPrint("Inputs:", color:"green")
    print("xf: \(xf)")
    print("yf: \(yf)")

    return fft_convolve(xf, y:yf)
}

func testFloatSameLengthSameMode() -> [Float] {

    let xf:[Float] = [1, 2, 3, 4, 5]
    let yf:[Float] = [5, 4, 3, 2, 1]

    colorPrint("Inputs:", color:"green")
    print("xf: \(xf)")
    print("yf: \(yf)")

    return fft_convolve(xf, y:yf, mode:"same")
}

func testFloatSameLengthValidMode() -> [Float] {

    let xf:[Float] = [1, 2, 3, 4, 5]
    let yf:[Float] = [5, 4, 3, 2, 1]

    colorPrint("Inputs:", color:"green")
    print("xf: \(xf)")
    print("yf: \(yf)")

    return fft_convolve(xf, y:yf, mode:"valid")
}

colorPrint("======== Float Array Tests Start ========", color: "yellow")

let answerSameLengthFull:[Float] = [5, 14, 26, 40, 55, 40, 26, 14, 5]
let answerSameLengthSame:[Float] = [26, 40, 55, 40, 26]
let answerSameLengthValid:[Float] = [55]

testEqualInTol("Float Same Length Array Full Mode",
               test: testFloatSameLengthFullMode,
               expect: answerSameLengthFull,
               tol:1e-5)

testEqualInTol("Float Same Length Array Same Mode",
               test: testFloatSameLengthSameMode,
               expect: answerSameLengthSame,
               tol:1e-5)

testEqualInTol("Float Same Length Array Valid Mode",
               test: testFloatSameLengthValidMode,
               expect: answerSameLengthValid,
               tol:1e-5)

func testFloatDifferentLengthFullMode() -> [Float]{

    let xf:[Float] = [1, 2, 3]
    let yf:[Float] = [1, 2, 3, 4, 5, 6]

    colorPrint("Inputs:", color:"green")
    print("xf: \(xf)")
    print("yf: \(yf)")

    return fft_convolve(xf, y:yf)
}

func testFloatDifferentLengthSameMode() -> [Float]{

    let xf:[Float] = [1, 2, 3]
    let yf:[Float] = [1, 2, 3, 4, 5, 6]

    colorPrint("Inputs:", color:"green")
    print("xf: \(xf)")
    print("yf: \(yf)")

    return fft_convolve(xf, y:yf, mode:"same")
}

func testFloatDifferentLengthValidMode() -> [Float]{

    let xf:[Float] = [1, 2, 3]
    let yf:[Float] = [1, 2, 3, 4, 5, 6]

    colorPrint("Inputs:", color:"green")
    print("xf: \(xf)")
    print("yf: \(yf)")

    return fft_convolve(xf, y:yf, mode:"valid")
}

let answerDifferentLengthFull:[Float] = [1, 4, 10, 16, 22, 28, 27, 18]
let answerDifferentLengthSame:[Float] = [4, 10, 16, 22, 28, 27]
let answerDifferentLengthValid:[Float] = [10, 16, 22, 28]

testEqualInTol("Float Different Length Array Full Mode",
                test: testFloatDifferentLengthFullMode,
                expect: answerDifferentLengthFull,
                tol:1e-5)

testEqualInTol("Float Different Length Array Same Mode",
                test: testFloatDifferentLengthSameMode,
                expect: answerDifferentLengthSame,
                tol:1e-5)

testEqualInTol("Float Different Length Array Valid Mode",
                test: testFloatDifferentLengthValidMode,
                expect: answerDifferentLengthValid,
                tol:1e-5)


func testSingleElementFullMode() -> [Float] {

    let xf:[Float] = [1]
    let yf:[Float] = [5]

    colorPrint("Inputs:", color:"green")
    print("xf: \(xf)")
    print("yf: \(yf)")

    return fft_convolve(xf, y:yf)
}

func testSingleElementSameMode() -> [Float] {

    let xf:[Float] = [1]
    let yf:[Float] = [5]

    colorPrint("Inputs:", color:"green")
    print("xf: \(xf)")
    print("yf: \(yf)")

    return fft_convolve(xf, y:yf, mode:"same")
}

func testSingleElementValidMode() -> [Float] {

    let xf:[Float] = [1]
    let yf:[Float] = [5]

    colorPrint("Inputs:", color:"green")
    print("xf: \(xf)")
    print("yf: \(yf)")

    return fft_convolve(xf, y:yf, mode:"valid")
}

let answerSingleElement:[Float] = [5]

testEqualInTol("Float Single Element Array Full Mode",
              test: testSingleElementFullMode,
              expect: answerSingleElement,
              tol:1e-5)

testEqualInTol("Float Single Element Array Same Mode",
              test: testSingleElementSameMode,
              expect: answerSingleElement,
              tol:1e-5)

testEqualInTol("Float Single Element Array Valid Mode",
              test: testSingleElementValidMode,
              expect: answerSingleElement,
              tol:1e-5)


func testFloatBadMode() -> [Float] {

    let xd:[Float] = [1, 2, 3]
    let yd:[Float] = [1, 2]

    return fft_convolve(xd, y:yd, mode:"bad mode")
}

let answerBadModeFloat:[Float] = [1, 4, 7, 6]
testEqual("Float Bad Mode",
          test: testFloatBadMode,
          expect: answerBadModeFloat)
