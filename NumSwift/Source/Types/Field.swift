//
// Dear maintainer:
//
// When I wrote this code, only I and God
// know what it was.
// Now, only God knows!
//
// So if you are done trying to 'optimize'
// this routine (and failed),
// please increment the following counter
// as warning to the next guy:
//
// var TotalHoursWastedHere = 0
//
// Reference: http://stackoverflow.com/questions/184618/what-is-the-best-comment-in-source-code-you-have-ever-encountered

import Foundation

/**
 ```
    Field: Comparable, CustomStringConvertible, Hashable
                     /      |      \
                  Double  Float    Int
 ```
 
 - Required Methods:
    - `init(_ num: Double)`
    - `init(_ num: Float)`
    - `init(_ num: Int)`
*/
public protocol Field:Comparable, CustomStringConvertible, Hashable {
    init(_ num: Double)
    init(_ num: Float)
    init(_ num: Int)
}

extension Double: Field {}
extension Float: Field {}
extension Int: Field {}