//
//  Created by DboyLiao on 4/1/16.
//  Copyright © 2016 DboyLiao
//

import XCTest
import NumSwift

class iOSMatrixUtilsTests:XCTestCase {
    
    func testDoubleMatricesMean() {
        var matrices = [Matrix<Double>]()
        matrices.append(Matrix<Double>(data:[1, 2, 3, 4], rows:2, cols:2)!)
        matrices.append(Matrix<Double>(data:[4, 3, 2, 1], rows:2, cols:2)!)
        matrices.append(Matrix<Double>(data:[4, 4, 4, 4], rows:2, cols:2)!)
        let meanMatrix = mean(of: matrices)
        let answer = Matrix<Double>(data:[3, 3, 3, 3], rows:2, cols:2)!
        
        XCTAssert(meanMatrix == answer, "answer: \(answer.data), result: \(meanMatrix.data)")
    }
    
    func testFloatMatricesMean() {
        var matrices = [Matrix<Float>]()
        matrices.append(Matrix<Float>(data:[1, 2, 3, 4], rows:2, cols:2)!)
        matrices.append(Matrix<Float>(data:[4, 3, 2, 1], rows:2, cols:2)!)
        matrices.append(Matrix<Float>(data:[4, 4, 4, 4], rows:2, cols:2)!)
        
        let meanMatrix = mean(of: matrices)
        let answer = Matrix<Float>(data:[3, 3, 3, 3], rows:2, cols:2)!
        
        XCTAssert(meanMatrix == answer, "answer: \(answer.data), result: \(meanMatrix.data)")
    }
    
    func testDoubleMatrixMean(){
        
        let matrix = Matrix<Double>(data:[1, 2, 3, 4], rows:2, cols:2)!
        let result = mean(of: matrix)
        let answer:Double = 2.5
        
        XCTAssert(result == answer, "answer: \(answer), result: \(result)")
        
    }
    
    func testFloatMatrixMean(){
        
        let matrix = Matrix<Float>(data:[1, 2, 3, 4], rows:2, cols:2)!
        let result = mean(of: matrix)
        let answer:Float = 2.5
        
        XCTAssert(result == answer, "answer: \(answer), result: \(result)")
    }
    
    func testDoubleMatrixNorm(){
        let matrix = Matrix<Double>(data:[2, 2, 2, 2], rows:2, cols:2)!
        
        let matrixNorm = norm(matrix)
        let answer = 4.0
        
        XCTAssert(matrixNorm == answer, "result: \(matrixNorm), answer: \(answer)")
    }
    
    func testFloatMatrixNorm(){
        let matrix = Matrix<Float>(data:[2, 2, 2, 2], rows:2, cols:2)!
        
        let matrixNorm = norm(matrix)
        let answer:Float = 4.0
        
        XCTAssert(matrixNorm == answer, "result: \(matrixNorm), answer: \(answer)")
    }
}