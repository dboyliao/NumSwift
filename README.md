# Numeric Operations for Swift

This project is just a simple practice on Swift and Accelerate framework.
The swift files contain some basic function used in numeric computation. The main functionality is build upon Accelearate framework which leaverages SIMD of the CPU, which make the codes run faster than native Swift code.

I am a big fan of `python`. In this project, you can find many of the functions mimic the API from `numpy` which is a popular package for scientific computation.

I hope you enjoy this package. Cheers.

# Dependency

- `Accelerate` framework
- `Foundation` framework

# Testing

First, change working directory to `NumSwift`.

## Setup Testing Environment

We use `numpy` (`python` package for numeric computation) as reference. Please setup the python environment by following steps:

- Instll `python` and `virtualenv`.
    + See this [guide](http://docs.python-guide.org/en/latest/dev/virtualenvs/) for detail of `virtualenv`
- Activate a testing virtual environment.
    ```{bash}
    virtualenv venv_test
    source venv_test/bin/activate
    ```
- Install required python packages
    + run `pip install -r requirements.txt`

You are ready to go!

## Running Tests for Swift
- Run `make test-osx` on Mac OSX.

# Build 

## Importable Module

- change working directory to `NumSwift`
- Run `make module`
- You will see a directory named `NumSwiftModule`
    + There are three files in that directory: `NumSwift.swiftmodule`, `NumSwift.swiftdoc` and `libNumSwift.dylib`
- Include files generated in `NumSwiftModule` in you Xcode Project.
    + If you hate Xcode just like me, you can use `swiftc` instead with flags `-I` and `-L`
    + ex: Suppose you have a `main.swift` and import `NumSwift` in it, you can run `xcrun -sdk macosx swiftc -I /path/to/NumSwiftModule -L /path/to/NumSwiftModule -lNumSwift -o main`. 

## Importable Framework

- Open `NumSwift.xcodeproj` under `NumSwift/NumSwift/` directory.
- Press `Build`.
- You should be able to see `NumSwift.framework` under `NumSwift/NumSwift/`. Drag the framework file to any project you'd like to use it.
- You should be able to import `NumSwift` in your project.

# References

## Accelerate Framework
- [Framework Reference](https://developer.apple.com/library/mac/documentation/Accelerate/Reference/vDSPRef/)
- [Simple Tutorial by admsyn](https://forum.openframeworks.cc/t/a-guide-to-speeding-up-your-of-app-with-accelerate-osx-ios/10560)
- [Surge](https://github.com/mattt/Surge)
- [UpSurge](https://github.com/aleph7/Upsurge/)
- [Recursive Type](https://forums.developer.apple.com/thread/19412)

## Fourier Transform
- [DFT v.s FFT](https://forums.developer.apple.com/thread/23321)
- [vDSP Guide - DFT](https://developer.apple.com/library/ios/documentation/Performance/Conceptual/vDSP_Programming_Guide/USingDFTFunctions/USingDFTFunctions.html#//apple_ref/doc/uid/TP40005147-CH4-SW1)
    + That is why we use `vDSP_DFT_XXX` rather than `vDSP_fft_XXX`.
    + The header file which states you should prefer `DFT` over `fft` is located in `/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.11.sdk/System/Library/Frameworks/Kernel.framework/Versions/Current/Headers/vecLib` on my computer. Go see it for yourself. 

## Matrix
- [StackOverflow - Inverse Matrix](http://stackoverflow.com/questions/11282746/how-to-perform-matrix-inverse-operation-using-the-accelerate-framework)

# Licence

MIT
