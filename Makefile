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
	xcrun -sdk macosx swiftc tests/main.swift Utilities.swift FFT.swift -o test
	echo 'Running test on FFT.'
	./test
	rm test tests/main.swift