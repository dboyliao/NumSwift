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
import Accelerate
import Foundation

/**
 Sum of Squares of Real Part and Image Part
 
 - Parameters:
    - z: DSPComplex number.
 
 - Returns: z.real^2 + z.imag^2
*/
public func norm(_ z:DSPComplex) -> Float {

    return z.real*z.real+z.imag*z.imag
}

/**
 Sum of Squares of Real Part and Image Part
 
 - Parameters:
    - z: DSPDoubleComplex number.
 
 - Returns: z.real^2 + z.imag^2
*/
public func norm(_ z:DSPDoubleComplex) -> Double {

    return z.real*z.real+z.imag*z.imag
}

/**
 Absolute Value
 
 - Parameters:
    - z: DSPComplex number.
 
 - Returns: Square root of norm of `z`
*/
public func abs(_ z:DSPComplex) -> Float {
    return sqrt(norm(z))
}

/**
 Absolute Value
 
 - Parameters:
    - z: DSPDoubleComplex number.
 
 - Returns: Square root of norm of `z`
*/
public func abs(_ z:DSPDoubleComplex) -> Double {
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
