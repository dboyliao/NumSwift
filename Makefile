test-osx:
	make test-complex-osx
	make test-trigonometry-osx
	make test-fft-osx
	make test-convolve-osx
	make test-fft-convolve-osx

test-complex-osx:
	cp tests/test_complex.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Complex.swift -o complex_test
	echo 'Running test on Complex.'
	./complex_test
	rm complex_test tests/main.swift

test-trigonometry-osx:
	cp tests/test_trigonometry.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Trigonometry.swift -o test_trigonometry
	echo 'Running test on Trigonometry.'
	./test_trigonometry
	rm test_trigonometry tests/main.swift

test-fft-osx:
	cp tests/test_fft.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/SwiftTest/*.swift tests/main.swift Sources/FFT.swift -o test_fft
	echo 'Running test on FFT.'
	./test_fft
	rm test_fft tests/main.swift

test-convolve-osx:
	cp tests/test_convolve.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Utilities.swift Sources/FFT.swift Sources/Convolution.swift -o test_convolve
	echo 'Running test on Convolution.'
	./test_convolve
	rm test_convolve tests/main.swift

test-fft-convolve-osx:
	cp tests/test_fft_convolve.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Sources/Utilities.swift Sources/Convolution.swift Sources/FFT.swift -o test_fft_convolve
	echo 'Running test on FFT-Convolution.'
	./test_fft_convolve
	rm test_fft_convolve tests/main.swift
