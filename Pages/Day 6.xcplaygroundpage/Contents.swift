//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

struct BankArray: Hashable, Equatable {
    var banks: [Int]
    
    var hashValue: Int {
        return banks.description.hashValue
    }
    static func == (lhs: BankArray, rhs: BankArray) -> Bool {
        return lhs.banks.description == rhs.banks.description
    }

    
}

let input1 = "0 2 7 0"
let input2 = """
14    0    15    12    11    11    3    5    1    6    8    4    9    1    8    4
"""

var banks = String(input2).split(separator: " ").map{ Int(String($0))! }
var seenBefore = Set<BankArray>()
var history = [Int:BankArray]()

for i in 1...10000 {
    let highest = banks.max()!
    let highestIndex = banks.index(of: highest)!
    banks[highestIndex] = 0
    var pointer = highestIndex
    for _ in (1...highest).reversed() {
        pointer = (pointer == banks.count - 1) ?  0 : pointer + 1
        banks[pointer] += 1
    }
    
    print(banks)
    let bankArray = BankArray(banks: banks)
    if(seenBefore.contains(bankArray)) {
        let itemIndex = history.index { key, value in
            return value.hashValue == bankArray.hashValue && value == bankArray
        }
        if(itemIndex != nil) {
            let originalPosition = history[itemIndex!].key
            print("Found a loop at position", i, ", originally found at", originalPosition, ", difference: ", i - originalPosition)
            break
            
        }
    }
    history[i] = bankArray
    seenBefore.insert(bankArray)
}



//: [Next](@next)
