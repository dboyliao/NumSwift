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

/**
 Compute the analytic signal, using the Hilbert transform. (1D signal)
 
 - Note: the implementation of the fft is limited to process signal with length 
         of power of 2. That is, the signal you pass in may be truncated to 
         shorter signals.
 #### References:
 1. Wikipedia, "Analytic signal". http://en.wikipedia.org/wiki/Analytic_signal
 
 - Parameters:
    - x: array of the signal.

 - Returns: a tuple consists of the real part and the imaginary part of the analytic
            signal.
*/
public func hilbert(_ x:[Double]) -> (realp:[Double], imagp:[Double]) {

    let signal = [Double](x)
    let zeros = [Double](repeating: 0.0, count: signal.count)
    var coef_sig = fft(signal, imagp:zeros)
    let N_fft = coef_sig.realp.count

    // Setup the step function `U` in the hilbert transform.
    // Represent as an array.
    var step_fun = [Double](repeating: 0.0, count: N_fft)
    step_fun[0] = 1.0
    step_fun[N_fft/2] = 1.0

    var two = 2.0
    vDSP_vfillD(&two, &(step_fun[1]), 1, vDSP_Length(N_fft/2 - 1))

    var output_realp = [Double](repeating: 0.0, count: N_fft)
    var output_imagp = [Double](repeating: 0.0, count: N_fft)

    vDSP_vmulD(&(coef_sig.realp), 1, &step_fun, 1, &output_realp, 1, vDSP_Length(N_fft))
    vDSP_vmulD(&(coef_sig.imagp), 1, &step_fun, 1, &output_imagp, 1, vDSP_Length(N_fft))

    return ifft(output_realp, imagp:output_imagp)

}

/**
 Compute the analytic signal, using the Hilbert transform. (1D signal)
 
 - Note: the implementation of the fft is limited to process signal with length 
         of power of 2. That is, the signal you pass in may be truncated to 
         shorter signals.
 
 #### References:
 1. Wikipedia, "Analytic signal". http://en.wikipedia.org/wiki/Analytic_signal
 
 - Parameters:
    - x: array of the signal.
 
 - Returns: a tuple consists of the real part and the imaginary part of the analytic 
            signal.
*/
public func hilbert(_ x:[Float]) -> (realp:[Float], imagp:[Float]) {

    let signal = [Float](x)
    let zeros = [Float](repeating: 0.0, count: signal.count)
    var coef_sig = fft(signal, imagp:zeros)
    let N_fft = coef_sig.realp.count

    // Setup the step function `U` in the hilbert transform.
    // Represent as an array.
    var step_fun = [Float](repeating: 0.0, count: N_fft)
    step_fun[0] = Float(1.0)
    step_fun[N_fft/2] = Float(1.0)

    var two = Float(2.0)
    vDSP_vfill(&two, &(step_fun[1]), 1, vDSP_Length(N_fft/2 - 1))

    var output_realp = [Float](repeating: 0.0, count: N_fft)
    var output_imagp = [Float](repeating: 0.0, count: N_fft)

    vDSP_vmul(&(coef_sig.realp), 1, &step_fun, 1, &output_realp, 1, vDSP_Length(N_fft))
    vDSP_vmul(&(coef_sig.imagp), 1, &step_fun, 1, &output_imagp, 1, vDSP_Length(N_fft))

    return ifft(output_realp, imagp:output_imagp)

}
