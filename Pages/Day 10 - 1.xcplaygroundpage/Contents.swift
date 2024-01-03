//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//let size = 5
//let lengths = [3, 4, 1, 5]
let size = 256
let lengths = [227,169,3,166,246,201,0,47,1,255,2,254,96,3,97,144]
var list = Array(0...size-1)

var curPos = 0
var skip = 0


for length in lengths {
    if(length > 1 && length <= size) {
        for i in 0...(length / 2 - 1) {
            let swap1 = (curPos + i) % size
            let swap2 = (curPos + length - i - 1) % size
            //print(swap1, swap2)
            list.swapAt(swap1, swap2)
        }
    }
    curPos += length + skip
    skip += 1
    print(list)
}
print("Answer: ", list[0] * list[1])

//: [Next](@next)
