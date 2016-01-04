test-osx:
	xcrun -sdk macosx swiftc -Onone *.swift -o test
	echo 'Running test.'
	./test
	rm test