//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let steps = 370
let endValue = 50_000_000//2017

var buffer = [0]
var curpos = 0
var valueAfterZero = 0

for i in 1...endValue {
    let jump = ((curpos + steps) % i) + 1
    //print("\(jump), \(curpos) \(steps) \(buffer.count)")
    if(jump == 1) {
        valueAfterZero = i
    }
    //buffer.insert(i, at: jump)
    curpos = jump
    //print(buffer)
}
print(valueAfterZero)
