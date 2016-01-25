import Foundation
import NumSwift

var N = Int(1 << 23) // input size
let repeatTime = 10

colorPrint("==== Start Python Hilbert Transform Performace Test ===", color:"blue")
system("python3 tests/scripts/hilbert_scipy.py \(N) \(repeatTime)")

colorPrint("\n==== Start Swift Hilbert Transform Performance Test ===", color:"blue")

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
    hilbert(sig)
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
print("best of \(repeatTime): \(durations.minElement()!) secs.")
colorPrint("mean time: \(mean)", color:"magenta")
colorPrint("std: \(std)", color:"magenta")

