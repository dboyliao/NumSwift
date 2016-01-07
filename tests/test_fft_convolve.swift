func main(){

    print("=== Double Array ===")
    var xd:[Double] = [1, 2, 3, 4, 5, 6]
    var yd:[Double] = [6, 5, 4, 3, 2, 1]

    print("xd: \(xd)")
    print("yd: \(yd)")
    print("full:", fft_convolve(xd, y:yd)!)
    print("same:", fft_convolve(xd, y:yd, mode:"same")!)
    print("valid:", fft_convolve(xd, y:yd, mode:"valid")!)
    print("")

    print("Bad mode:")
    print(fft_convolve(xd, y:yd, mode:"bad"))
    print("")

    xd = [1.0]
    yd = [5.0]
    print("xd: \(xd)")
    print("yd: \(yd)")
    print("full:", fft_convolve(xd, y:yd)!)
    print("same:", fft_convolve(xd, y:yd, mode:"same")!)
    print("valid:", fft_convolve(xd, y:yd, mode:"valid")!)
    print("")

    print("=== Float Array ===")
    var xf:[Float] = [1, 2, 3, 4, 5, 6]
    var yf:[Float] = [6, 5, 4, 3, 2, 1]
    print("xf: \(xf)")
    print("yf: \(yf)")

    print("full:", fft_convolve(xf, y:yf)!)
    print("same:", fft_convolve(xf, y:yf, mode:"same")!)
    print("valid:", fft_convolve(xf, y:yf, mode:"valid")!)
    print("")

    print("Bad mode:")
    print(fft_convolve(xf, y:yf, mode:"bad"))
    print("")

    xf = [1.0]
    yf = [5.0]
    print("xf: \(xf)")
    print("yf: \(yf)")
    print("full:", fft_convolve(xf, y:yf)!)
    print("same:", fft_convolve(xf, y:yf, mode:"same")!)
    print("valid:", fft_convolve(xf, y:yf, mode:"valid")!)
    print("")
}

main()