func main(){
    let N: Int = 16
    // Testing fft
    print("=== testing fft for [Float] ===")
    var sigf = [Float](count:N, repeatedValue:0.0)
    for i in 0..<N {
        sigf[i] = Float(i+1)
    }
    print("sigf: \(sigf)")
    let zerosf = [Float](count:N, repeatedValue:0.0)

    let (coeff_realp, coeff_imagp) = fft(sigf, imagp:zerosf)
    for i in 0..<N {
        print("\(i): \(coeff_realp[i])+\(coeff_imagp[i])j")
    }

    print("== inverse fft [Float] ===")
    let (sigf_realp, sigf_imagp) = ifft(coeff_realp, imagp: coeff_imagp)
    for i in 0..<N {
        print("\(i): \(sigf_realp[i]) \(sigf_imagp[i])j")
    }

    print("=== testing fft for [Double] ===")
    var sigd = [Double](count:N, repeatedValue:0.0)
    let zerosd = [Double](count:N, repeatedValue:0.0)
    for i in 0..<N {
        sigd[i] = Double(i+1)
    }
    print("sigd: \(sigd)")

    let (coefd_realp, coefd_imagp) = fft(sigd, imagp:zerosd)
    for i in 0..<N {
        print("\(i): \(coefd_realp[i]) \(coefd_imagp[i])j")
    }

    print("== inverse fft [Double] ===")
    let (sigd_realp, sigd_imagp) = ifft(coefd_realp, imagp: coefd_imagp)
    for i in 0..<N {
        print("\(i): \(sigd_realp[i]) \(sigd_imagp[i])j")
    }
}

main()