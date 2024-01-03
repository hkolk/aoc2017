//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

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

let fileURL = Bundle.main.url(forResource: "input2", withExtension: "txt")
let input = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
let lines = input.split(separator: "\n").map { String($0) }

let columnsize = lines.reduce(0, { accu, element in
    return max(element.count, accu)
})
let rowsize = lines.count

var matrix = Array<Array<Character>>()

for y in 0...rowsize-1 {
    //print(lines[y])
    matrix.append(Array(lines[y]) + Array(repeating:" ", count: columnsize - lines[y].count))
}
enum Direction {
    case north, west, south, east
    
    func nextPos(_ curX:Int, _ curY:Int) -> (Int, Int) {
        switch self {
            case .north: return (curX, curY-1)
            case .south: return (curX, curY+1)
            case .west:  return (curX-1, curY)
            case .east:  return (curX+1, curY)
        }
    }
    
    func left() -> Direction {
        switch self {
        case .north: return .west
        case .south: return .east
        case .west:  return .south
        case .east:  return .north
        }
    }
    
    func right() -> Direction {
        switch self {
        case .north: return .east
        case .south: return .west
        case .west:  return .north
        case .east:  return .south
        }
    }
}

func isPathway(_ x:Int, _ y:Int) -> Bool {
    if((x < 0 || x >= columnsize) ||
        (y < 0 || y >= rowsize) ||
        (matrix[y][x] == " ")) {
        return false
    } else {
        return true
    }
}

var (curX, curY) = (x: matrix[0].index(of: "|")!, 0)
var direction = Direction.south
var stringAccu = ""
var steps = 1

outerloop: while(true) {
    //print("At \(curX) \(curY)")
    let (nextX, nextY) = direction.nextPos(curX, curY)
    if(!isPathway(nextX, nextY)) {
        // change direction
        let (leftX, leftY) = direction.left().nextPos(curX, curY)
        let (rightX, rightY) = direction.right().nextPos(curX, curY)
        if(isPathway(leftX, leftY)) {
            direction = direction.left()
        } else if(isPathway(rightX, rightY)) {
            direction = direction.right()
        } else {
            break outerloop
        }
    } else {
        if(matrix[nextY][nextX] != "+" && matrix[nextY][nextX] != "|" && matrix[nextY][nextX] != "-") {
            stringAccu.append(matrix[nextY][nextX])
        }
        steps += 1
        curX = nextX
        curY = nextY
    }
}
print("String accu: \(stringAccu)")
print("Steps: \(steps)")



