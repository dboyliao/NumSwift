test-osx:
	make test-complex-osx
	make test-trigonometry-osx
	make test-fft-osx
	make test-convolve-osx
	make test-fft-convolve-osx

test-complex-osx:
	cp tests/test_complex.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Complex.swift -o complex_test
	echo 'Running test on Complex.'
	./complex_test
	rm complex_test tests/main.swift

test-trigonometry-osx:
	cp tests/test_trigonometry.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Trigonometry.swift -o test
	echo 'Running test on Trigonometry.'
	./test
	rm test tests/main.swift

test-fft-osx:
	cp tests/test_fft.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift FFT.swift -o test
	echo 'Running test on FFT.'
	./test
	rm test tests/main.swift

test-convolve-osx:
	cp tests/test_convolve.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Utilities.swift FFT.swift Convolution.swift -o convolve_test
	echo 'Running test on Convolution.'
	./convolve_test
	rm convolve_test tests/main.swift

test-fft-convolve-osx:
	cp tests/test_fft_convolve.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift tests/SwiftTest/*.swift Utilities.swift Convolution.swift FFT.swift -o test_fft_convolve
	echo 'Running test on FFT-Convolution.'
	./test_fft_convolve
	rm test_fft_convolve tests/main.swift
