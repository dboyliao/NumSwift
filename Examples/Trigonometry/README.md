## Source
`Sources/Trigonometry.swift`

## Dependency

1. `Accelerate` framework

## Example Code

```{swift}
import Foundation
import NumSwift

let N = 10
var x = [Double](count:N+1, repeatedValue:0.0)

for i in 0...N {
    x[i] = 2*M_PI*Double(i)/Double(N)
}

sin(x)
cos(x)
sec(x)
csc(x)
tan(x)
cot(x)
```
