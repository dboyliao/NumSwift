let xd:[Double] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
let xf:[Float] = [1, 2, 3, 4, 5, 6, 7, 8, 9]

func testArraySplitDouble() -> [[Double]]{

    let result = splitArrayIntoParts(xd, 5)
    print(result)

    return result
}

func testArraySplitFloat() -> [[Float]]{

    let result = splitArrayIntoParts(xf, 5)
    print(result)
    
    return result

}

let answerD:[[Double]] = [[1, 2], [3, 4], [5, 6], [7, 8], [9]]
let answer:[[Float]] = [[1, 2], [3, 4], [5, 6], [7, 8], [9]]

testEqual("Split Array Double", test:testArraySplitDouble, expect:answerD)
testEqual("Split Array Float", test:testArraySplitFloat, expect:answer)