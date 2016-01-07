test-osx:
	make test-complex-osx
	make test-trigonometry-osx
	make test-fft-osx
	make test-convolve-osx
	make test-fft-convolve-osx

test-complex-osx:
	cp tests/test_complex.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift Complex.swift -o test
	echo 'Running test on Complex.'
	./test
	rm test tests/main.swift

test-trigonometry-osx:
	cp tests/test_trigonometry.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift Trigonometry.swift -o test
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
	xcrun -sdk macosx swiftc tests/main.swift Utilities.swift FFT.swift Convolution.swift -o test
	echo 'Running test on Convolution.'
	./test
	rm test tests/main.swift

test-fft-convolve-osx:
	cp tests/test_fft_convolve.swift tests/main.swift
	xcrun -sdk macosx swiftc tests/main.swift Utilities.swift Convolution.swift FFT.swift -o test
	echo 'Running test on FFT-Convolution.'
	./test
	rm test tests/main.swift
