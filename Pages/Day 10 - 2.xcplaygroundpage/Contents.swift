//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

extension Array {
    func chunks(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}
extension String {
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let stringLength = self.characters.count
        if stringLength < toLength {
            return String(repeatElement(character, count: toLength - stringLength)) + self
        } else {
            return String(self.suffix(toLength))
        }
    }
}
extension Int {
    func toHex() -> String {
        return String(self, radix: 16).leftPadding(toLength: 2, withPad: "0")
    }
}

//let size = 5
//let lengths = [3, 4, 1, 5]
//let lengths = [227,169,3,166,246,201,0,47,1,255,2,254,96,3,97,144]
let input = "227,169,3,166,246,201,0,47,1,255,2,254,96,3,97,144"
let size = 256
let rounds = 64
    
let lengths = input.map{ Int($0.unicodeScalars.first!.value) } + [17, 31, 73, 47, 23]

print(lengths)

var list = Array(0...size-1)

var curPos = 0
var skip = 0

for _ in 1...rounds {
    for length in lengths {
        if(length > 1 && length <= size) {
            for i in 0...(length / 2 - 1) {
                let swap1 = (curPos + i) % size
                let swap2 = (curPos + length - i - 1) % size
                //print(swap1, swap2)
                list.swapAt(swap1, swap2)
            }
        }
        curPos += (length + skip) % size
        skip += 1
        //print(list)
    }
}

let denseHash = list.chunks(16).map{$0.reduce(0, { result, item in
    return result ^ item
} )}.map { $0.toHex()  }.joined()
print(denseHash)
print("Answer: ", list[0] * list[1])

//: [Next](@next)

