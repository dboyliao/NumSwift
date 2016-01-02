// Testing Complex number
var a = Complex(real:1.0, imag:2.0)
var b = Complex(real:1.0, imag:1.0)
var c = a + b
print("\(c.real) + \(c.imag)i")

// Testin arrays
var xf:[Float] = [1.0, 2.0, 3.0, 3.14159265]
var xd:[Double] = [1.0, 2.0, 3.0, 3.14159265358979]
print("xf: \(xf)")
print("xd: \(xd)")

// Testing trigonometry.
print("cos(xf): \(cos(xf))")
print("cos(xd): \(cos(xd))")
print("tan(xf): \(tan(xf))")
print("tan(xd): \(tan(xd))")
print("cot(xf): \(cot(xf))")
print("cot(xd): \(cot(xd))")
print("csc(xf): \(csc(xf))")
print("csc(xd): \(csc(xd))")