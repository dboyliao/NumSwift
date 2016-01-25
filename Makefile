SOURCES=$$(pwd)/Sources
MODULE_NAME=NumSwift
BUILD_DIR=NumSwiftModule

temp:
	echo $(SOURCES)
	xcrun -sdk macosx swift -I "$$($(SOURCES))"

module:
	mkdir -p $(BUILD_DIR)
	xcrun -sdk macosx swiftc -I $(SOURCES) -L $(SOURCES) -emit-module-path $(BUILD_DIR)/$(MODULE_NAME).swiftmodule -module-link-name $(MODULE_NAME) -module-name $(MODULE_NAME) $(SOURCES)/*.swift $(SOURCES)/Signal/*.swift -emit-library -o $(BUILD_DIR)/libNumSwift.dylib

test-osx:
	make test-complex-osx
	make test-trigonometry-osx
	make test-fft-osx
	make test-convolve-osx
	make test-fft-convolve-osx
	make test-hilbert-osx
	make test-abs-osx
	make test-arange-osx
	make test-mean-osx
	make test-split-array-osx
	make test-norm-osx

test-complex-osx:
	cp tests/test_complex.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o complex_test
	echo 'Running test on Complex.'
	./complex_test
	rm complex_test tests/main.swift

test-trigonometry-osx:
	cp tests/test_trigonometry.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/SwiftTest/*.swift tests/main.swift -o test_trigonometry
	echo 'Running test on Trigonometry.'
	./test_trigonometry
	rm test_trigonometry tests/main.swift

test-fft-osx:
	cp tests/test_fft.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/SwiftTest/*.swift tests/main.swift -o test_fft
	echo 'Running test on FFT.'
	./test_fft
	rm test_fft tests/main.swift


test-fft-convolve-osx:
	cp tests/test_fft_convolve.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o test_fft_convolve
	echo 'Running test on FFT-Convolution.'
	./test_fft_convolve
	rm test_fft_convolve tests/main.swift

test-hilbert-osx:
	cp tests/test_hilbert.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o test_hilbert
	echo 'Running test on Hilber Transform.'
	./test_hilbert
	rm test_hilbert tests/main.swift

test-convolve-osx:
	cp tests/test_convolve.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o test_convolve
	echo 'Running test on Convolution.'
	./test_convolve
	rm test_convolve tests/main.swift

test-abs-osx:
	cp tests/test_abs.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o test_abs
	echo 'Running test on abs'
	./test_abs
	rm test_abs tests/main.swift

test-arange-osx:
	cp tests/test_arange.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o test_arange
	echo 'Running test arange'
	./test_arange
	rm test_arange tests/main.swift

test-mean-osx:
	cp tests/test_mean.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o test_mean
	echo 'Running test mean'
	./test_mean
	rm test_mean tests/main.swift

test-split-array-osx:
	cp tests/test_split_array.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o test_split_array
	echo 'Running test on array spliting'
	./test_split_array
	rm test_split_array tests/main.swift

test-linspace-osx:
	cp tests/test_linspace.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o test_linspace
	echo 'Running test on linspace'
	./test_linspace
	rm test_linspace tests/main.swift

test-round-osx:
	cp tests/test_round.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o test_round
	echo 'Running test on rounding to zero'
	./test_round
	rm test_round tests/main.swift

test-sqrt-osx:
	cp tests/test_sqrt.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o test_sqrt
	echo 'Running test on sqrt'
	./test_sqrt
	rm test_sqrt tests/main.swift

test-norm-osx:
	cp tests/test_norm.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o test_norm
	echo 'Running test on norm'
	./test_norm
	rm test_norm tests/main.swift

test-std-osx:
	cp tests/test_std.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o test_std
	echo 'Running test on std'
	./test_std
	rm test_std tests/main.swift

test-normalize-osx:
	cp tests/test_normalize.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o test_normalize
	echo 'Running test on normalize'
	./test_normalize
	rm test_normalize tests/main.swift

performance:
	make performance-fft
	make performance-ifft
	make performance-fft-convolve
	make performance-hilbert
	# make performance-convolve # buggy

performance-fft:
	cp tests/performance_fft.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o performance-fft
	./performance-fft
	rm performance-fft tests/main.swift

performance-ifft:
	cp tests/performance_ifft.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o performance-ifft
	./performance-ifft
	rm performance-ifft tests/main.swift

performance-fft-convolve:
	cp tests/performance_fft_convolve.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o performance-fft-convolve
	./performance-fft-convolve
	rm performance-fft-convolve tests/main.swift

performance-hilbert:
	cp tests/performance_hilbert.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o performance_hilbert
	./performance_hilbert
	rm performance_hilbert tests/main.swift

performance-convolve:
	cp tests/performance_convolve.swift tests/main.swift
	xcrun -sdk macosx swiftc -I $(BUILD_DIR) -L $(BUILD_DIR) -l$(MODULE_NAME) tests/main.swift tests/SwiftTest/*.swift -o performance-convolve
	./performance-convolve
	rm performance-convolve tests/main.swift
