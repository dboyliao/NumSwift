//
//  Created by DboyLiao on 3/31/16.
//  Copyright © 2016 DboyLiao.
//

import XCTest
import NumSwift

class iOSNumSwiftTests: XCTestCase {
    
    // MARK: - Matrix Multiplication Tests
    func testDoubleMatrixMultiplication() {
        
        var dataA = [Double](1.stride(to: 5, by: 1))
        var dataB = [Double](4.stride(to: 0, by: -1))
        var matA = Matrix<Double>(data:dataA, rows:2, cols:2)!
        var matB = Matrix<Double>(data:dataB, rows:2, cols:2)!
        var result = matA * matB
        var answer = Matrix<Double>(data:[8.0, 5.0, 20.0, 13.0], rows:2, cols:2)!
        XCTAssert(answer == result, "answer:\(answer.data), result: \(result.data)")
        
        dataA = [Double](1.stride(to: 7, by: 1))
        dataB = [Double](12.stride(to: 0, by: -1))
        matA = Matrix<Double>(data:dataA, rows:2, cols:3)!
        matB = Matrix<Double>(data:dataB, rows:3, cols:4)!
        result = matA * matB
        answer = Matrix<Double>(data:[40.0, 34.0, 28.0, 22.0, 112.0, 97.0, 82.0, 67.0], rows:2, cols:4)!
        XCTAssert(result == answer, "answer:\(answer.data), result: \(result.data)")
    }
    
    func testDoubleMatrixScalarMultiplication(){
        let mat = Matrix<Double>(data:[1, 2, 3, 4], rows:2, cols:2)!
        let answer = Matrix<Double>(data:[2, 4, 6, 8], rows:2, cols:2)!
        var result = mat * 2
        XCTAssert(result == answer, "answer:\(answer.data), result: \(result.data)")
        
        result = 2 * mat
        XCTAssert(result == answer, "answer:\(answer.data), result: \(result.data)")
    }
    
    func testFloatMatrixScalarMultiplication(){
        let mat = Matrix<Float>(data:[1, 2, 3, 4], rows:2, cols:2)!
        let answer = Matrix<Float>(data:[2, 4, 6, 8], rows:2, cols:2)!
        var result = mat * 2
        XCTAssert(result == answer, "answer:\(answer.data), result: \(result.data)")
        
        result = 2 * mat
        XCTAssert(result == answer, "answer:\(answer.data), result: \(result.data)")
    }
    
    func testFloatMatrixMultiplication() {
        var dataA:[Float] = [1, 2, 3, 4]
        var dataB:[Float] = [4, 3, 2, 1]
        var matA = Matrix<Float>(data:dataA, rows:2, cols:2)!
        var matB = Matrix<Float>(data:dataB, rows:2, cols:2)!
        var result = matA * matB
        var answer = Matrix<Float>(data:[Float]([8.0, 5.0, 20.0, 13.0]), rows:2, cols:2)!
        XCTAssert(result == answer, "answer:\(answer.data), result: \(result.data)")
        
        dataA = [Float](count:6, repeatedValue:0)
        dataB = [Float](count:12, repeatedValue:0)
        for i in 0..<12 {
            if i < 6 {
                dataA[i] = Float(i+1)
            }
            dataB[i] = Float(12-i)
        }
        matA = Matrix<Float>(data:dataA, rows:2, cols:3)!
        matB = Matrix<Float>(data:dataB, rows:3, cols:4)!
        result = matA * matB
        answer = Matrix<Float>(data:[Float]([40.0, 34.0, 28.0, 22.0, 112.0, 97.0, 82.0, 67.0]), rows:2, cols:4)!
        XCTAssert(result == answer, "answer:\(answer.data), result: \(result.data)")
    }
    
    func testDoubleMatrixAddition(){
        let dataA:[Double] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let dataB:[Double] = [9, 8, 7, 6, 5, 4, 3, 2, 1]
        let matA = Matrix<Double>(data:dataA, rows:3, cols:3)!
        let matB = Matrix<Double>(data:dataB, rows:3, cols:3)!
        let answer = Matrix<Double>(data:[Double](count:9, repeatedValue:10), rows:3, cols:3)!
        let result = matA + matB
        
        XCTAssert(result == answer, "answer:\(answer.data), result:\(result.data)")
    }
    
    func testFloatMatrixAddition(){
        let dataA:[Float] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let dataB:[Float] = [9, 8, 7, 6, 5, 4, 3, 2, 1]
        let matA = Matrix<Float>(data:dataA, rows:3, cols:3)!
        let matB = Matrix<Float>(data:dataB, rows:3, cols:3)!
        let answer = Matrix<Float>(data:[Float](count:9, repeatedValue:10), rows:3, cols:3)!
        let result = matA + matB
        
        XCTAssert(result == answer, "answer:\(answer.data), result:\(result.data)")
    }
    
    func testDoubleMatrixSubtraction(){
        let dataA:[Double] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let dataB:[Double] = [9, 8, 7, 6, 5, 4, 3, 2, 1]
        let matA = Matrix<Double>(data:dataA, rows:3, cols:3)!
        let matB = Matrix<Double>(data:dataB, rows:3, cols:3)!
        let answer = Matrix<Double>(data:[-8, -6, -4, -2, 0, 2, 4, 6, 8], rows:3, cols:3)!
        let result = matA - matB
        
        XCTAssert(result == answer, "answer:\(answer.data), result:\(result.data)")
    }
    
    func testFloatMatrixSubtraction(){
        let dataA:[Float] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        let dataB:[Float] = [9, 8, 7, 6, 5, 4, 3, 2, 1]
        let matA = Matrix<Float>(data:dataA, rows:3, cols:3)!
        let matB = Matrix<Float>(data:dataB, rows:3, cols:3)!
        let answer = Matrix<Float>(data:[-8, -6, -4, -2, 0, 2, 4, 6, 8], rows:3, cols:3)!
        let result = matA - matB
        
        XCTAssert(result == answer, "answer:\(answer.data), result:\(result.data)")
    }
    
    // MARK: - Matrix Performance Tests
    func testPerformanceDoubleMatrixMultiplication() {
        
        let dataA = [Double](0.stride(to: 1000000, by: 1))
        let dataB = [Double](1000000.stride(to: 0, by: -1))
        let matA = Matrix<Double>(data:dataA, rows:1000, cols:1000)!
        let matB = Matrix<Double>(data:dataB, rows:1000, cols:1000)!
        self.measureBlock {
            matA * matB
        }
    }
    
    func testPerformanceFloatMatrixMultiplication(){
        var dataA = [Float](count:1000000, repeatedValue:0)
        var dataB = [Float](count:1000000, repeatedValue:0)
        for i in 0..<1000000{
            dataA[i] = Float(i)
            dataB[i] = Float(2000000 - i)
        }
        let matA = Matrix<Float>(data:dataA, rows:1000, cols:1000)!
        let matB = Matrix<Float>(data:dataB, rows:1000, cols:1000)!
        self.measureBlock {
            matA * matB
        }
    }
    
}
