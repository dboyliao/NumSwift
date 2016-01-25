import NumSwift

let x:[Double] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
let y:[Double] = [1, 1, 1]

// It's recommended to use `fft_convolve` rather than `convolve`.
// `convolve` is still buggy right now.

// `x` convolve `y` in "full" mode
fft_convolve(x, y:y)

// `x` convolve `y` in "same" mode
fft_convolve(x, y:y, mode:"same")

// `x` convolve `y` in "valid" mode
fft_convolve(x, y:y, mode:"valid")
