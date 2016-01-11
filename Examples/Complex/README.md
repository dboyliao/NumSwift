## Source
`Sources/Complex.swift`

## Dependency

1. `Foundation` framework
2. `Accelerate` framework

## Example Code

```{swift}
import Accelerate

let z1 = DSPComplex(real:1, imag:0)
let z2 = DSPComplex(real:0, imag:-1)

var z = z1 + z2
// z: DSPComplex(real:1.0, imag:-1.0)

z = z1 - z2
// z: DSPComplex(real:1.0, imag:1.0)

z = z1 * z2
// z: DSPComplex(real:0.0, imag:-1.0)

z = z1 / z2
// z: DSPComplex(real:0.0, imag:1.0)
```
