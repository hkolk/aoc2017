//: [Previous](@previous)

import Foundation

extension String {
    
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

//: [Next](@next)

enum Move {
    case spin(number: Int)
    case exchange(pos1:Int, pos2:Int)
    case partner(program1:String, program2:String)
    
    static func convert(line:String) -> Move {
        switch line[0] {
        case "s": return .spin(number: Int(line.substring(fromIndex: 1))!)
        case "x":
            let components = line.substring(fromIndex:1).split(separator: "/")
            return .exchange(pos1: Int(components[0])!, pos2: Int(components[1])!)
        case "p":
            let components = line.substring(fromIndex:1).split(separator: "/")
            return .partner(program1: String(components[0]), program2: String(components[1]))
        default: fatalError("Found an unknown move: \(line)")
        }
    }
    
    func executeMove(slots:Array<String>) -> Array<String> {
        switch self {
        case .spin(let number):
            let lastPart = slots[(slots.count-number)...]
            let firstPart = slots[0...(slots.count-number-1)]
            return Array(lastPart + firstPart)
        case .exchange(let pos1, let pos2):
            var newSlots = slots
            newSlots.swapAt(pos1, pos2)
            return newSlots
        case .partner(let program1, let program2):
            var newSlots = slots
            let pos1 = newSlots.index(of: program1)!
            let pos2 = newSlots.index(of: program2)!
            newSlots.swapAt(pos1, pos2)
            return newSlots
            
        }
    }
}

let input = """
s1,x3/4,pe/b
""".split(separator: ",").map{ String($0) }
let input2 = """

""".split(separator: ",").map{ String($0) }
var slots = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"]
//var slots = ["a", "b", "c", "d", "e"]
let originalvalue = slots.joined()

var moves = Array<Move>()
for line in input2 {
    moves.append(Move.convert(line: line))
}
for  {
for move in moves {
    slots = move.executeMove(slots: slots)
}
} while(slots.joined() != originalvalue)
print(slots.joined())
