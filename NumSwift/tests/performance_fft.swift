import Foundation
import NumSwift

var N = Int(1 << 18) // input size
let repeatTime = 1000

colorPrint("==== Start Python FFT Performace Test ===", color:"blue")
system("python3 tests/scripts/fft_numpy.py \(N) \(repeatTime)")

colorPrint("\n==== Start Swift FFT Performance Test ===", color:"blue")

var sig = [Double](count:N, repeatedValue:0.0)
let zeros = [Double](sig)

// initialize sig.
for i in 0..<N {
    sig[i] = Double(i+1)
}

var durations = [Double]()
var start:NSDate
var end:NSDate

for _ in 0..<repeatTime {

    start = NSDate()
    fft(sig, imagp:zeros)
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


print("input size: \(N)")
colorPrint("best of \(repeatTime): \(durations.minElement()!) secs.", color:"cyan")
colorPrint("mean time: \(mean)", color:"magenta")
colorPrint("std: \(std)", color:"magenta")

