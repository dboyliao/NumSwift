//
//  Created by DboyLiao on 4/1/16.
//  Copyright © 2016 DboyLiao.
//

import XCTest
import NumSwift


class iOSUtilityFunctionTests: XCTestCase {
    
    func testNormDouble(){
        let x:[Double] = [1, 2, 3, 4, 5, 6, 7, 8]
        let y:[Double] = [8, 7, 6, 5, 4, 3, 2, 1]
        let answer:[Double] = [8.06225775, 7.28010989, 6.70820393, 6.40312424,
                               6.40312424, 6.70820393, 7.28010989, 8.06225775]
        let result = norm(x, y)
        let (pass, maxDifference) = testAllClose(result, answer, tol: 1e-8)
        XCTAssert(pass, "maxDiff: \(maxDifference), result: \(result)")
        
    }
    
    func testNormFloat(){
        let x:[Float] = [1, 2, 3, 4, 5, 6, 7, 8]
        let y:[Float] = [8, 7, 6, 5, 4, 3, 2, 1]
        let answer:[Float] = [8.06225775, 7.28010989, 6.70820393, 6.40312424,
                              6.40312424, 6.70820393, 7.28010989, 8.06225775]
        let result = norm(x, y)
        let (pass, maxDifference) = testAllClose(result, answer, tol:1e-8)
        XCTAssert(pass, "maxDiff: \(maxDifference), result: \(result)")
    }
    
    func tesRoundDouble() {
        let x:[Double] = [1.1, -2.3, 5.6, 2.7, -3.1415926]
        let answer:[Double] = [1, -2, 5, 2, -3]
        let result = roundToZero(x)
        
        XCTAssert(result == answer, "answer: \(answer), result: \(result)")
    }
    
    func testRoundFloat(){
        let x:[Float] = [1.1, -2.3, 5.6, 2.7, -3.1415926]
        let answer:[Float] = [1, -2, 5, 2, -3]
        let result = roundToZero(x)
        
        XCTAssert(result == answer, "answer: \(answer), result: \(result)")
    }
    
    
    func testArangeDouble(){
        
        let resultD = arange(5, step:1.0)
        let answerD:[Double] = [0, 1, 2, 3, 4]
        
        XCTAssert(resultD == answerD, "answerD: \(answerD), resultD: \(resultD)")
    }
    
    func testArangeFloat(){
        let resultF:[Float] = arange(5, step:Float(1.0))
        let answerF:[Float] = [0, 1, 2, 3, 4]
        
        XCTAssert(resultF == answerF, "answerF: \(answerF), resultF: \(resultF)")
    }
    
    func testLinspaceDouble(){
        let result = linspace(1.0, 10.0, num:10)
        let answer:[Double] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        XCTAssert(result == answer, "answer: \(answer), result: \(result)")
    }
    
    func testLinspaceFloat(){
        let result = linspace(Float(1.0), Float(10.0), num:10)
        let answer:[Float] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        
        XCTAssert(result == answer, "answer: \(answer), result: \(result)")
    }
    
    func testMeanDouble(){
        
        let x:[Double] = [1, 2, 3, 4]
        let result = mean(x)
        let answer = 2.5
        
        XCTAssert(result == answer, "answer: \(answer), result: \(result)")
        
    }
    
    func testMeanFloat(){
        
        let x:[Float] = [1, 2, 3, 4]
        let result = mean(x)
        let answer:Float = 2.5
        
        XCTAssert(result == answer, "answer: \(answer), result: \(result)")
        
    }
    
    func testVarianceDouble(){
        
        let x = stride(from: 1, to: 11, by: 1).map { Double($0) }
        let result = variance(x)
        let answer:Double = 8.25
        
        XCTAssert(result == answer, "answer: \(answer), result: \(result)")
        
    }
    
    func testVarianceFloat(){
        
        let x = stride(from: 1, to: 11, by: 1).map { Float($0) }
        let result = variance(x)
        let answer:Float = 8.25
        
        XCTAssert(result == answer, "answer: \(answer), result: \(result)")
        
    }
    
    func testStdDouble(){
        
        let x = stride(from: 1, to: 11, by: 1).map { Double($0) }
        let result = std(x)
        let answer:Double = 2.8722813232690143
        
        XCTAssert(result == answer, "answer: \(answer), result: \(result)")
        
    }
    
    func testStdFloat(){
        
        let x = stride(from: 1, to: 11, by: 1).map { Float($0) }
        let result = std(x)
        let answer:Float = 2.8722813232690143
        
        XCTAssert(result == answer, "answer: \(answer), result: \(result)")
        
    }
    
    func testNormalizeDouble(){
        let x = stride(from: 1, to:11, by:1).map { Double($0) }
        let result = normalize(x)
        let answer:[Double] = [-1.5666989, -1.21854359, -0.87038828, -0.52223297, -0.17407766,
                               0.17407766,  0.52223297,  0.87038828,  1.21854359,  1.5666989]
        let tol = 1e-8
        let (pass, maxDiff) = testAllClose(result, answer, tol:tol)
        
        XCTAssert(pass, "tol:\(tol), maxDiff:\(maxDiff)")
    }
    
    func testNormalizeFloat(){
        
        let x = stride(from: 1, to:11, by:1).map { Float($0) }
        let result = normalize(x)
        let answer:[Float] = [-1.5666989, -1.21854359, -0.87038828, -0.52223297, -0.17407766,
                               0.17407766,  0.52223297,  0.87038828,  1.21854359,  1.5666989]
        let tol:Float = 1e-6
        let (pass, maxDiff) = testAllClose(result, answer, tol:tol)
        
        XCTAssert(pass, "tol:\(tol), maxDiff:\(maxDiff)")
    }
    
    func testSplitArray(){
        
        let xd:[Double] = (1...20).map { Double($0) }
        let xf:[Float] = (1...20).map { Float($0) }
        
        let resultD = splitArrayIntoParts(xd, 3)
        let resultF = splitArrayIntoParts(xf, 3)
        
        let answerD:[[Double]] = [[1, 2, 3, 4, 5, 6, 7], [8, 9, 10, 11, 12, 13, 14], [15, 16, 17, 18, 19, 20]].map { $0.map {Double($0)} }
        let answerF:[[Float]] = [[1, 2, 3, 4, 5, 6, 7], [8, 9, 10, 11, 12, 13, 14], [15, 16, 17, 18, 19, 20]].map { $0.map {Float($0)} }
        
        XCTAssert(resultD.count == answerD.count, "answerD.count: \(answerD.count), resultD.count: \(resultD.count)")
        XCTAssert(resultF.count == answerF.count, "answerF.count: \(answerF.count), resultF.count: \(resultF.count)")
        
        for index in 0..<resultD.count {
            XCTAssertEqual(resultD[index], answerD[index], "resultD is different from answerD at \(index) position: \(resultD[index]) v.s \(answerD[index])")
        }
        
        for index in 0..<resultF.count {
            XCTAssertEqual(resultF[index], answerF[index], "resultF is different from answerF at \(index) position: \(resultF[index]) v.s \(answerF[index])")
        }
    }
    
    func testLeastPowerOfTwo(){
        let result = leastPowerOfTwo(1023)
        let resultD = leastPowerOfTwo(1023.0)
        let resultF = leastPowerOfTwo(Float(1023))
        
        let answer = 1024
        let answerD:Double = 1024
        let answerF:Float = 1024
        
        XCTAssert(result == answer, "answer: \(answer), result: \(result)")
        XCTAssert(resultD == answerD, "answerD: \(answerD), resultD: \(resultD)")
        XCTAssert(resultF == answerF, "answerD: \(answerF), resultD: \(resultF)")
    }
}
