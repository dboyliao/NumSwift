let x:[Double] = [1, 2, 3, 4, 5, 6, 7, 8]

let (x_recovered, x_hilbert) = hilbert(x)
// `x_hilbert` is the hilbert transform of `x`
// `x_recovered` should be very close to `x`
// Behide the scene, hilbert transform make use of fft which is not limited
// to process only signal of length of power of 2. In this example, length of
// `x` is 8 which is 2 raised to power 3. That is why `x_recovered` is a perfect
// match with `x`. In other case, `x` may be truncated to length of nearest power
// of 2.