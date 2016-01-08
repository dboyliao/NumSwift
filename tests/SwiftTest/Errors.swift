import Foundation

enum TestingError: ErrorType {
    case NotEqualError(message: String)
    case LengthError(message: String)
}