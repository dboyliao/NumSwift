# Matrix - Intro

`NumSwift` now support basic matrix operation except inversion (coming soon...I promise).

You can choose from three different kind of `Field`, `Double` and `Float`. `Int`, by definition, 

is not a field. However I still make it work in `NumSwift` for syntax sugar purpose. Using an 

`Int` matrix is not recommanded.

# Matrix - Basic Usage

Here we take `Double` matrix for example. `Float` matrix works in the same way.

## Matrix Construction

```{swift}
import NumSwift

// 2x2 identity matrix. It's row-major matrix by default.
let matrix = Matrix<Double>(data:[1, 0, 0, 1], rows:2, cols:2)!

matrix.rows 
// the number of rows: 2
matrix.cols 
// the number of cols: 2
matrix.data
// an array which stores the elements of a matrix: [1, 0, 0, 1]. It's read-only property.
matrix[0, 0]
// 1
matrix[0, 1]
// 0
```

## Matrix Arithmetic

```{swift}
import NumSwift

let A = Matrix<Double>(data:[1, 2, 3, 4], rows:2, cols:2)!
let B = Matrix<Double>(data:[1, 1, 1, 1], rows:2, cols:2)!

// multiplication
A * B // == Matrix<Double>(data:[3, 3, 7, 7], rows:2, cols:2)!
// addition
A + B // == Matrix<Double>(data:[2, 3, 4, 5], rows:2, cols:2)!
// subtraction
A - B // == Matrix<Double>(data:[0, 1, 2, 3], rows:2, cols:2)!
// inverse
// (coming soon....)
```

## Matrix Memeory Management

```{swift}
import NumSwift

let matrix = Matrix<Double>(data:[1, 2, 3, 4], rows:2, cols:2)!
// the order of the data: could be `CblasRowMajor` or `CblasColMajor` (structs defined in `Accelerate`).
matrix.order // default: `CblasRowMajor`
matrix.data // [1, 2, 3, 4]: row-major

// You can change the order by calling `setDataOrder:` method.
matrix.setDataOrder(CblasColMajor)
matrix.data // [1, 3, 2, 4]: column-major
```
