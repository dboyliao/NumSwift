# Numeric Operations for Swift

This project is just a simple practice on Swift and Accelerate framework.
The swift files contain some basic function used in numeric computation. The main functionality is build upon Accelearate framework which leaverages SIMD of the CPU, which make the codes run faster than native Swift code.

I personally am a `python` lover. In this project, you can find many of the functions mimic the API from `numpy` which is a popular package for scientific computation.

I hope you enjoy this package. Cheers.

# Dependency

- `Accelerate` framework
- `Foundation` framework

# Testing
Run `make test-osx` on Mac OSX.

# References

## Accelerate Framework
- [Framework Reference](https://developer.apple.com/library/mac/documentation/Accelerate/Reference/vDSPRef/)
- [Simple Tutorial by admsyn](https://forum.openframeworks.cc/t/a-guide-to-speeding-up-your-of-app-with-accelerate-osx-ios/10560)
- [Surge](https://github.com/mattt/Surge)

## Fourier Transform
- [DFT v.s FFT](https://forums.developer.apple.com/thread/23321)
- [vDSP Guide - DFT](https://developer.apple.com/library/ios/documentation/Performance/Conceptual/vDSP_Programming_Guide/USingDFTFunctions/USingDFTFunctions.html#//apple_ref/doc/uid/TP40005147-CH4-SW1)
    + That is why we use `vDSP_DFT_XXX` rather than `vDSP_fft_XXX`.

# Licence

MIT
