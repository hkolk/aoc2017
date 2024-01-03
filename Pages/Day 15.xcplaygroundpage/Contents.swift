//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

struct Generator : IteratorProtocol {
    var previousValue:Int
    let factor:Int
    let picker:Int
    
    init(factor:Int, startingValue:Int, picker:Int) {
        self.factor = factor
        self.previousValue = startingValue
        self.picker = picker
    }
    
    mutating func next() -> Int? {
        repeat {
            previousValue = (previousValue * factor) % 2147483647
        } while(previousValue % picker > 0)
        return previousValue
    }
}

var genA = Generator(factor: 16807, startingValue: 65, picker:4)
var genB = Generator(factor: 48271, startingValue: 8921, picker:8)

var judgeCounter = 0

for _ in 1...5000 {
    let aValue = genA.next()!
    let bValue = genB.next()!
    print("\(aValue) \(bValue)")

    if((aValue & 0xFFFF) == (bValue & 0xFFFF)) {
        print("Match! \(aValue) \(bValue)")
        judgeCounter += 1
    }
    //print("--------")

}
print("Judge Counter: \(judgeCounter)")

//: [Next](@next)
