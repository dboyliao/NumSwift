let N_radix2 = 16 // 2 to 4-th power.
var x = [Double](count:N_radix2, repeatedValue:0.0)
var zeros = [Double](x)

for i in 0..<N_radix2 {
    x[i] = Double(i+1)
}

var (coef_realp, coef_imagp) = fft(x, imagp:zeros) // complex-to-complex fft.
var (x_recovered, _) = ifft(coef_realp, imagp:coef_imagp) // complex-to-complex ifft.
print(x_recovered)
// `x_recovered` should be very closed to original `x`

let N_NotRadix2 = 17 // it is not a power of 2.
x = [Double](count:N_NotRadix2, repeatedValue:0.0)
zeros = [Double](x)

for i in 0..<N_NotRadix2 {
    x[i] = Double(i+1)
}

(coef_realp, coef_imagp) = fft(x, imagp:zeros)
(x_recovered, _) = ifft(coef_realp, imagp:coef_imagp)
print(x_recovered)

// `x_recovered`, in this case, should be very closed to `x[0..<16]`.
// Since `fft` first truncates `x` to be of length 16 (2 raised to power of 4) 
// and then perform fourier transform on truncated signal.
