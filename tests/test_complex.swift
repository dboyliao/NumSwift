func main(){
    // Testing Complex number
    let a = Complex(real:1.0, imag:2.0)
    let b = Complex(real:1.0, imag:1.0)
    let c = a + b
    print("\(c.real) + \(c.imag)i")
}

main()