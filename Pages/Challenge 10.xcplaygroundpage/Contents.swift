//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

func measure(_ title: String, block: (() -> ()) -> ()) {
    
    let startTime = CFAbsoluteTimeGetCurrent()
    
    block {
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("\(title):: Time: \(timeElapsed)")
    }
}

func challenge10(input: String) -> (vowels: Int, consenants: Int) {
    return input.lowercased().unicodeScalars.reduce(into: (vowels: 0, consenants: 0), { accu, char in
        if(CharacterSet.letters.contains(char)) {
            switch char {
            case "a","e","i","u","o": accu.vowels += 1
            default: accu.consenants += 1
            }
        }
    })
}
challenge10(input: "Swift Coding Challenges") == (6, 15)
challenge10(input: "Mississippi") == (4, 7)
