import Accelerate

public func hilbert(x:[Double]) -> (realp:[Double], imagp:[Double]) {
    /*
    Compute the analytic signal, using the Hilbert transform.
    (1D signal)

    `params`:
        `x`: array of the signal.

    `return`: a tuple

    Note:
        1. the implementation of the fft is limited to process
           signal with length of power of 2. That is, the signal
           you pass in may be truncated to shorter signals.

    References:
        [1] Wikipedia, "Analytic signal".
        http://en.wikipedia.org/wiki/Analytic_signal
    */

    let signal = [Double](x)
    let zeros = [Double](count:signal.count, repeatedValue:0.0)
    var coef_sig = fft(signal, imagp:zeros)
    let N_fft = coef_sig.realp.count

    // Setup the step function `U` in the hilbert transform.
    // Represent as an array.
    var step_fun = [Double](count:N_fft, repeatedValue:0.0)
    step_fun[0] = 1.0
    step_fun[N_fft/2] = 1.0

    var two = 2.0
    vDSP_vfillD(&two, &(step_fun[1]), 1, vDSP_Length(N_fft/2 - 1))

    var output_realp = [Double](count:N_fft, repeatedValue:0.0)
    var output_imagp = [Double](count:N_fft, repeatedValue:0.0)

    vDSP_vmulD(&(coef_sig.realp), 1, &step_fun, 1, &output_realp, 1, vDSP_Length(N_fft))
    vDSP_vmulD(&(coef_sig.imagp), 1, &step_fun, 1, &output_imagp, 1, vDSP_Length(N_fft))

    return ifft(output_realp, imagp:output_imagp)

}

public func hilbert(x:[Float]) -> (realp:[Float], imagp:[Float]) {
    /*
    Compute the analytic signal, using the Hilbert transform.
    (1D signal)

    `params`:
        `x`: array of the signal.

    `return`: a tuple

    Note:
        1. the implementation of the fft is limited to process
           signal with length of power of 2. That is, the signal
           you pass in may be truncated to shorter signals.

    References:
        [1] Wikipedia, "Analytic signal".
        http://en.wikipedia.org/wiki/Analytic_signal
    */

    let signal = [Float](x)
    let zeros = [Float](count:signal.count, repeatedValue:0.0)
    var coef_sig = fft(signal, imagp:zeros)
    let N_fft = coef_sig.realp.count

    // Setup the step function `U` in the hilbert transform.
    // Represent as an array.
    var step_fun = [Float](count:N_fft, repeatedValue:0.0)
    step_fun[0] = Float(1.0)
    step_fun[N_fft/2] = Float(1.0)

    var two = Float(2.0)
    vDSP_vfill(&two, &(step_fun[1]), 1, vDSP_Length(N_fft/2 - 1))

    var output_realp = [Float](count:N_fft, repeatedValue:0.0)
    var output_imagp = [Float](count:N_fft, repeatedValue:0.0)

    vDSP_vmul(&(coef_sig.realp), 1, &step_fun, 1, &output_realp, 1, vDSP_Length(N_fft))
    vDSP_vmul(&(coef_sig.imagp), 1, &step_fun, 1, &output_imagp, 1, vDSP_Length(N_fft))

    return ifft(output_realp, imagp:output_imagp)

}
