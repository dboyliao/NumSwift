//: Playground - noun: a place where people can play
import Accelerate

var matrix:[Double] = [1, 1, 7, 1, 2, 1, 1, 1, 3]
var pivots = [Int32](count:3, repeatedValue:0)
var N = [Int32(3)]
var error = [Int32(0)]
dgetrf_(&N, &N, &matrix, &N, &pivots, &error)
matrix
pivots
error[0]

