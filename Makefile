test-osx:
	xcrun -sdk macosx swiftc *.swift -o test
	echo 'Running test.'
	./test
	rm test