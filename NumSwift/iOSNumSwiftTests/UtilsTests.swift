//
//  Created by DboyLiao on 4/1/16.
//  Copyright © 2016 DboyLiao.
//

import XCTest
import NumSwift


class UtilityFunctionTests: XCTestCase {
    
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
}