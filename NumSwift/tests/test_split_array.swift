import Foundation
import NumSwift

let numOfSplits = 20

let xd = read_csvD("./tests/data/test_split_array.csv")
let xf = read_csv("./tests/data/test_split_array.csv")

let splitsDouble = splitArrayIntoParts(xd, numOfSplits)
let splitsFloat = splitArrayIntoParts(xf, numOfSplits)

func genTestCaseDouble(i:Int) -> (() -> [Double]) {

    func testCase() -> [Double] {

        return splitsDouble[i]
    }

    return testCase

}

func genTestCaseFloat(i:Int) -> (() -> [Float]) {

    func testCase() -> [Float] {

        return splitsFloat[i]
    }

    return testCase

}


system("./tests/scripts/gen_split_array_test_cases.py -n \(numOfSplits)")

var testCaseDouble:()->[Double]
var testCaseFloat:()->[Float]
var answerDouble:[Double]
var answerFloat:[Float]

for i in 0..<numOfSplits {

    answerDouble = read_csvD("./tests/data/output_split_array_\(i+1).csv")
    testCaseDouble = genTestCaseDouble(i)

    testEqualInTol("Test on \(i+1)th Split Double", test:testCaseDouble, expect:answerDouble, tol:1e-9)
}

for i in 0..<numOfSplits {

    answerFloat = read_csv("./tests/data/output_split_array_\(i+1).csv")
    testCaseFloat = genTestCaseFloat(i)

    testEqualInTol("Test on \(i+1)th Split Float", test:testCaseFloat, expect:answerFloat, tol:1e-3)
}

system("rm ./tests/data/output_split_array_*.csv")
