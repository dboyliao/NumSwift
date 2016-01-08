import Foundation

enum TestingError: ErrorType {
    case NotEqualError(message: String)
    case AssertionError(message: String)
}