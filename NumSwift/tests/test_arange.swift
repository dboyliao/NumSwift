import NumSwift

func testArangeDoubleNoStart() -> [Double] {

    let result = arangeD(5)
    return result

}

func testArangeDoubleWithStart() -> [Double] {

    let result = arangeD(5, start:12)
    return result

}

let answerD1:[Double] = [1, 2, 3, 4, 5]
let answerD2:[Double] = [12, 13, 14, 15, 16]

testEqual("arange Double No Start", test:testArangeDoubleNoStart, expect:answerD1)
testEqual("arange Double With Start", test:testArangeDoubleWithStart, expect:answerD2)

