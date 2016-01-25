import Foundation
import NumSwift

let M = 1000001 // input size
let N = 48576  // input size
let repeatTime = 500

colorPrint("M: \(M)", color:"white")
colorPrint("N: \(N)", color:"white")
colorPrint("repeatTime: \(repeatTime)", color:"white")

colorPrint("==== Start Python FFT Convolution performace Test ===", color:"blue")
system("python3 tests/scripts/fftconvolve_scipy.py \(M) \(N) \(repeatTime)")

colorPrint("\n==== Start Swift FFT Convolution Performance Test ===", color:"blue")

var x = [Double](count:M, repeatedValue:0.0)
var y = [Double](count:N, repeatedValue:0.0)

// initialize x and y.
for i in 0..<M {
    x[i] = Double(i+1)
}

for i in 0..<N {
    y[i] = Double(N+1)
}

var durations = [Double]()
var start:NSDate
var end:NSDate

for _ in 0..<repeatTime {

    start = NSDate()
    fft_convolve(x, y:y)
    end = NSDate()

    durations.append(Double(end.timeIntervalSinceDate(start)))
}

func standardDeviation(arr : [Double]) -> Double
{
    let length = Double(arr.count)
    let avg = arr.reduce(0.0){$0 + $1} / length
    let sumOfSquaredAvgDiff = arr.map{pow($0 - avg, 2.0)}.reduce(0){$0 + $1}
    return sqrt(sumOfSquaredAvgDiff / length)
}

let mean = durations.reduce(0.0) {
    $0 + $1/Double(durations.count)
}
let std = standardDeviation(durations)


print("input size: \nx:\(M)\ny:\(N)")
colorPrint("best of \(repeatTime): \(durations.minElement()!) secs.", color:"cyan")
colorPrint("mean time: \(mean)", color:"magenta")
colorPrint("std: \(std)", color:"magenta")
