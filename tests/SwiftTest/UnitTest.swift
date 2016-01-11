import Foundation

func execute_test<T:Equatable>(label: String, test:() -> T) -> T {
    
    NSLog("%@", label)

    let start = NSDate()

    defer {
        let end = NSDate()
        let duration = end.timeIntervalSinceDate(start)
        NSLog("%@ takes %5.3g seconds.", label, duration)
    }

    let result = test()

    return result
}

func execute_test<T:Equatable>(label: String, test:() -> [T]) -> [T] {

    NSLog("%@", label)

    let start = NSDate()

    defer {
        let end = NSDate()
        let duration = end.timeIntervalSinceDate(start)
        NSLog("%@ takes %5.3g seconds.", label, duration)
    }

    let result = test()

    return result
}

func equal<T:Equatable>(label: String, test: () -> T, expect:T) throws {

    let result = execute_test(label, test:test)

    if result != expect {
        throw TestingError.NotEqualError(message:"Output: \(result)\nExpect: \(expect).")
    }

    colorPrint("[\(label)] pass.", color:"blue")

}

func equal<T:Equatable>(label: String, test: () -> [T], expect:[T]) throws {

    let result = execute_test(label, test:test)

    if result.count != expect.count {
        throw TestingError.LengthError(message:"Array length do not match.")
    }

    if result != expect {

        throw TestingError.NotEqualError(message:"Output: \(result)\nExpect: \(expect).")
    }

    colorPrint("[\(label)] pass.", color:"blue")
    colorPrint("Output: \(result)", color:"cyan")
    colorPrint("Expect: \(expect)", color:"cyan")
}

func testEqual<T:Equatable>(label: String, test:() -> T, expect: T) {

    do {

        try equal(label, test:test, expect:expect)

    } catch TestingError.NotEqualError(let message){

        colorPrint("[\(label)] fail.", color:"red")
        colorPrint(message, color:"magenta")

    } catch {

        colorPrint("Uncatched Error....", color:"red")

    }

    colorPrint("\n============\n", color: "yellow")

}

func testEqual<T:Equatable>(label: String, test:() -> [T], expect: [T]) {

    do {

        try equal(label, test:test, expect:expect)

    } catch TestingError.NotEqualError(let message){

        colorPrint("[\(label)] fail.", color:"red")
        colorPrint(message, color:"magenta")

    } catch {

        colorPrint("Uncatched Error....", color:"red")

    }

    colorPrint("\n============\n", color: "yellow")

}

func equalInTol(label: String, test:() -> [Double], expect: [Double], tol:Double) throws {

    let result = execute_test(label, test:test)

    if result.count != expect.count {
        throw TestingError.LengthError(message:"Array length do not match.")
    }

    if !testAllClose(result, y:expect, tol:tol) {

        throw TestingError.NotEqualError(message:"Output: \(result)\nExpect: \(expect).")
    }

    colorPrint("[\(label)] pass.", color:"blue")
    colorPrint("Output: \(result)", color:"cyan")
    colorPrint("Expect: \(expect)", color:"cyan")
    colorPrint("Tolerance: \(tol)", color:"cyan")

}

func testEqualInTol(label: String, test:() -> [Double], expect: [Double], tol: Double) {

    do {

        try equalInTol(label, test:test, expect:expect, tol:tol)

    } catch TestingError.NotEqualError(let message){

        colorPrint("[\(label)] fail.", color:"red")
        colorPrint(message, color:"magenta")
        colorPrint("Tolerance: \(tol)", color:"magenta")

    } catch {

        colorPrint("Uncatched Error....", color:"red")

    }

    colorPrint("\n============\n", color: "yellow")

}

func equalInTol(label: String, test:() -> [Float], expect: [Float], tol:Float) throws {

    let result = execute_test(label, test:test)

    if result.count != expect.count {
        throw TestingError.LengthError(message:"Array length do not match.")
    }

    if !testAllClose(result, y:expect, tol:tol) {

        throw TestingError.NotEqualError(message:"Output: \(result)\nExpect: \(expect).")
    }

    colorPrint("[\(label)] pass.", color:"blue")
    colorPrint("Output: \(result)", color:"cyan")
    colorPrint("Expect: \(expect)", color:"cyan")
    colorPrint("Tolerance: \(tol)", color:"cyan")

}

func testEqualInTol(label: String, test:() -> [Float], expect: [Float], tol: Float) {

    do {

        try equalInTol(label, test:test, expect:expect, tol:tol)

    } catch TestingError.NotEqualError(let message){

        colorPrint("[\(label)] fail.", color:"red")
        colorPrint(message, color:"magenta")
        colorPrint("Tolerance: \(tol)", color:"magenta")

    } catch {

        colorPrint("Uncatched Error....", color:"red")

    }

    colorPrint("\n============\n", color: "yellow")

}
