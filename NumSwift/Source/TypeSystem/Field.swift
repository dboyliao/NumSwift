import Foundation

public protocol Field:Comparable, CustomStringConvertible, Hashable {
    init(_ num: Double)
    init(_ num: Float)
    init(_ num: Int)
}

extension Double: Field {}
extension Float: Field {}
extension Int: Field {}