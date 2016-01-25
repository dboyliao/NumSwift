import NumSwift

let xd:[Double] = [1.1, -2.3, 5.6, 2.7, -3.1415926]
let xf:[Float] = [1.1, -2.3, 5.6, 2.7, -3.1415926]

func testRoundDouble() -> [Double]{

    colorPrint("Input: \(xd)", color:"yellow")

    return roundToZero(xd)

}

func testRoundFloat() -> [Float] {

    colorPrint("Input: \(xf)", color:"yellow")

    return roundToZero(xf)

}

let answerDouble:[Double] = [1, -2, 5, 2, -3]
let answerFloat:[Float] = [1, -2, 5, 2, -3]

testEqual("Test Round to Zero Double", test:testRoundDouble, expect:answerDouble)
testEqual("Test Round to Zero Float", test:testRoundFloat, expect:answerFloat)