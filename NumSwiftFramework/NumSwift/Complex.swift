import Accelerate
import Foundation

public func norm(z:DSPComplex) -> Float {

    return z.real*z.real+z.imag*z.imag
}

public func norm(z:DSPDoubleComplex) -> Double {

    return z.real*z.real+z.imag*z.imag
}

public func abs(z:DSPComplex) -> Float {
    return sqrt(norm(z))
}

public func abs(z:DSPDoubleComplex) -> Double {
    return sqrt(norm(z))
}

// +
public func +(left:DSPComplex, right:DSPComplex) -> DSPComplex {

    let real = left.real + right.real
    let imag = left.imag + right.imag

    return DSPComplex(real:real, imag:imag)
}

public func +(left:DSPDoubleComplex, right:DSPDoubleComplex) -> DSPDoubleComplex {

    let real = left.real + right.real
    let imag = left.imag + right.imag

    return DSPDoubleComplex(real:real, imag:imag)
}

// -

public func -(left:DSPComplex, right:DSPComplex) -> DSPComplex {

    let real = left.real - right.real
    let imag = left.imag - right.imag

    return DSPComplex(real:real, imag:imag)
}

public func -(left:DSPDoubleComplex, right:DSPDoubleComplex) -> DSPDoubleComplex {

    let real = left.real - right.real
    let imag = left.imag - right.imag

    return DSPDoubleComplex(real:real, imag:imag)
}

// *

public func *(left:DSPComplex, right:DSPComplex) -> DSPComplex{

    let real = left.real*right.real - left.imag*right.imag
    let imag = left.imag*right.real + left.real*right.imag

    return DSPComplex(real:real, imag:imag)
}


public func *(left:DSPDoubleComplex, right:DSPDoubleComplex) -> DSPDoubleComplex{

    let real = left.real*right.real - left.imag*right.imag
    let imag = left.imag*right.real + left.real*right.imag

    return DSPDoubleComplex(real:real, imag:imag)
}

// /

public func /(left:DSPComplex, right:DSPComplex) -> DSPComplex{

    let rightNorm = norm(right)
    let real = (left.real*right.real + left.imag*right.imag)/rightNorm
    let imag = (left.imag*right.real - left.real*right.imag)/rightNorm

    return DSPComplex(real:real, imag:imag)
}


public func /(left:DSPDoubleComplex, right:DSPDoubleComplex) -> DSPDoubleComplex{

    let rightNorm = norm(right)
    let real = (left.real*right.real + left.imag*right.imag)/rightNorm
    let imag = (left.imag*right.real - left.real*right.imag)/rightNorm

    return DSPDoubleComplex(real:real, imag:imag)
}
