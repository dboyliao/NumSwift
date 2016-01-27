import Accelerate
import Foundation

/**
 Sum of Squares of Real Part and Image Part
 
 - Parameters:
    - z: DSPComplex number.
 
 - Returns: z.real^2 + z.imag^2
*/
public func norm(z:DSPComplex) -> Float {

    return z.real*z.real+z.imag*z.imag
}

/**
 Sum of Squares of Real Part and Image Part
 
 - Parameters:
    - z: DSPDoubleComplex number.
 
 - Returns: z.real^2 + z.imag^2
*/
public func norm(z:DSPDoubleComplex) -> Double {

    return z.real*z.real+z.imag*z.imag
}

/**
 Absolute Value
 
 - Parameters:
    - z: DSPComplex number.
 
 - Returns: Square root of norm of `z`
*/
public func abs(z:DSPComplex) -> Float {
    return sqrt(norm(z))
}

/**
 Absolute Value
 
 - Parameters:
    - z: DSPDoubleComplex number.
 
 - Returns: Square root of norm of `z`
*/
public func abs(z:DSPDoubleComplex) -> Double {
    return sqrt(norm(z))
}

/**
 Addition for Complex Numbers
*/
public func +(left:DSPComplex, right:DSPComplex) -> DSPComplex {

    let real = left.real + right.real
    let imag = left.imag + right.imag

    return DSPComplex(real:real, imag:imag)
}

/**
 Addition for Complex Numbers
*/
public func +(left:DSPDoubleComplex, right:DSPDoubleComplex) -> DSPDoubleComplex {

    let real = left.real + right.real
    let imag = left.imag + right.imag

    return DSPDoubleComplex(real:real, imag:imag)
}

/**
 Substraction for Complex Numbers
*/
public func -(left:DSPComplex, right:DSPComplex) -> DSPComplex {

    let real = left.real - right.real
    let imag = left.imag - right.imag

    return DSPComplex(real:real, imag:imag)
}

/**
 Substraction for Complex Numbers
*/
public func -(left:DSPDoubleComplex, right:DSPDoubleComplex) -> DSPDoubleComplex {

    let real = left.real - right.real
    let imag = left.imag - right.imag

    return DSPDoubleComplex(real:real, imag:imag)
}

/**
 Multiplication for Complex Numbers
*/
public func *(left:DSPComplex, right:DSPComplex) -> DSPComplex{

    let real = left.real*right.real - left.imag*right.imag
    let imag = left.imag*right.real + left.real*right.imag

    return DSPComplex(real:real, imag:imag)
}

/**
 Multiplication for Complex Numbers
*/
public func *(left:DSPDoubleComplex, right:DSPDoubleComplex) -> DSPDoubleComplex{

    let real = left.real*right.real - left.imag*right.imag
    let imag = left.imag*right.real + left.real*right.imag

    return DSPDoubleComplex(real:real, imag:imag)
}

/**
 Division for Complex Numbers
*/
public func /(left:DSPComplex, right:DSPComplex) -> DSPComplex{

    let rightNorm = norm(right)
    let real = (left.real*right.real + left.imag*right.imag)/rightNorm
    let imag = (left.imag*right.real - left.real*right.imag)/rightNorm

    return DSPComplex(real:real, imag:imag)
}

/**
 Division for Complex Numbers
 */
public func /(left:DSPDoubleComplex, right:DSPDoubleComplex) -> DSPDoubleComplex{

    let rightNorm = norm(right)
    let real = (left.real*right.real + left.imag*right.imag)/rightNorm
    let imag = (left.imag*right.real - left.real*right.imag)/rightNorm

    return DSPDoubleComplex(real:real, imag:imag)
}
