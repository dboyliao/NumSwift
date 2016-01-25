import NumSwift

func testLinspaceDouble() -> [Double]{

    return linspace(1.0, 10.0, num:10)

}

func testLinspaceFloat() -> [Float]{

    let one:Float = 1
    let ten:Float = 10.0

    return linspace(one, ten, num:10)

}

let answerDouble:[Double] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let answerFloat:[Float] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

testEqual("Test Linspace Double", test:testLinspaceDouble, expect:answerDouble)
testEqual("Test Linspace Float", test:testLinspaceFloat, expect:answerFloat)