// FFT
func getEvenOddArray<T>(array:[T]) -> ([T], [T]){
    var evenArray = [T]()
    var oddArray = [T]()

    for idx in 0..<array.count{
        if idx % 2 == 0 {
            evenArray.append(array[idx])
        } else {
            oddArray.append(array[idx])
        }
    }
    return (evenArray, oddArray)
}


// func fftfreq(N: Int, d: Double) -> [Double]{

// }

// func abs(x: [DSPDoubleComplex]){

// }

// func abs(x: [[DSPComplex]]){

// }