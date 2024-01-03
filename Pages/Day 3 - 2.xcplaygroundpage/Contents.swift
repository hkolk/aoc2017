//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

enum Direction {
    case left, right, up, down
}

extension Int {
    func square() -> Int {
        return self * self
    }
}

struct Coords: Hashable {
    let x:Int
    let y:Int
    
    var hashValue: Int {
        return x ^ y
    }
    
    static func == (lhs: Coords, rhs: Coords) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
}

func calculateHighestLayerNumber(_ forLayer: Int) -> Int {
    return (forLayer * 2 + 1).square()
}

func calculateLayer(_ forNumber:Int) -> Int {
    var layer = 0
    while(forNumber > calculateHighestLayerNumber(layer) ) {
        layer += 1
    }
    return layer
}

let max = 1000

var matrix = [Coords: Int]()
var matrix2 = [Coords: Int]()
var lookup = [Int: (Int, Int, Direction, Int)]()


var curX = 0
var curY = 0
var direction:Direction = .right

matrix[Coords(x: 0, y: 0)] = 1
matrix2[Coords(x: 0, y: 0)] = 1

lookup[1] = (0, 0, .right, 1)

func eightBox(_ curX:Int, _ curY:Int) -> Int {
    var accu = 0
    for x in -1...1 {
        for y in -1...1 {
            let lookup = matrix2[Coords(x: curX + x, y: curY + y)] ?? 0
            accu += lookup
            //print(curX + x, curY + y, accu, lookup)
        }
    }
    return accu
}

for i in 2...max {
    let layer = calculateLayer(i)
    
    switch(direction) {
    case .right:
        curX += 1
        if(curX >= layer && i != calculateHighestLayerNumber(layer)) { direction = .up }
    case .up:
        curY += 1
        if(curY >= layer) { direction = .left }
    case .left:
        curX -= 1
        if(curX <= 0-layer) { direction = .down }
    case .down:
        curY -= 1
        if(curY <= 0-layer) { direction = .right }
        
    }
    
    matrix[Coords(x: curX, y: curY)] = i
    //print("8box for ", i, curX, curY)
    let eightBoxValue = eightBox(curX, curY)
    matrix2[Coords(x: curX, y: curY)] = eightBoxValue
    lookup[i] = (curX, curY, direction, eightBoxValue)
    if eightBoxValue > 289326 {
        print(eightBoxValue)
        break;
    }

}

matrix[Coords(x:0, y:0)]
lookup[1]
lookup[2]
lookup[3]
lookup[4]
lookup[5]
lookup[6]
lookup[7]
lookup[8]
lookup[9]
lookup[10]
lookup[11]
lookup[12]
lookup[13]
lookup[14]
lookup[15]
lookup[1024]
lookup[1025]
lookup[1026]




//: [Next](@next)
