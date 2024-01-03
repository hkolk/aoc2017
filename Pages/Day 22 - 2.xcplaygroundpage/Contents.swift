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

enum NodeStatus {
    case clean, weakened, flagged, infected
}

enum Direction {
    case north, west, south, east
    
    func nextDirection(status: NodeStatus) -> Direction {
        switch self {
        case .north:
            switch status {
            case .clean: return .west   // left
            case .infected: return .east // right
            case .weakened: return .north // same
            case .flagged: return .south // reverse
            }
        case .south:
            switch status {
            case .clean: return .east   // left
            case .infected: return .west // right
            case .weakened: return .south // same
            case .flagged: return .north // reverse
            }
        case .west:
            switch status {
            case .clean: return .south   // left
            case .infected: return .north // right
            case .weakened: return .west // same
            case .flagged: return .east // reverse
            }
        case .east:
            switch status {
            case .clean: return .north   // left
            case .infected: return .south // right
            case .weakened: return .east // same
            case .flagged: return .west // reverse
            }
        }
    }
}

struct Point2D : Hashable {
    let x: Int
    let y: Int
    
    var hashValue: Int {
        return "(\(x),\(y))".hashValue
    }
    
    static func == (lhs: Point2D, rhs: Point2D) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    
    func move(direction:Direction) -> Point2D {
        switch direction {
        case .north: return Point2D(x: x, y: y+1)
        case .south: return Point2D(x: x, y: y-1)
        case .west:  return Point2D(x: x-1, y: y)
        case .east:  return Point2D(x: x+1, y: y)
        }
    }
    
}


class Carrier {
    var infections = Dictionary<Point2D, NodeStatus>()
    var currentDirection = Direction.north
    var currentLocation = Point2D(x: 0, y: 0)
    var numberOfInfections = 0
    
    init(_ infections: Dictionary<Point2D, NodeStatus>) {
        self.infections = infections
    }
    
    func changeDirection() {
        let status = infections[currentLocation] ?? NodeStatus.clean
        currentDirection = currentDirection.nextDirection(status: status)
    }
    
    func actionOnCurrentNode() {
        let currentStatus = infections[currentLocation] ?? NodeStatus.clean
        switch currentStatus {
            case .clean:
                infections[currentLocation] = .weakened
            case .weakened:
                numberOfInfections += 1
                infections[currentLocation] = .infected
            case .infected:
                infections[currentLocation] = .flagged
            case .flagged:
                infections.removeValue(forKey: currentLocation)
        }
    }
    
    func move() {
        currentLocation = currentLocation.move(direction: currentDirection)
    }
    
    func tick() {
        changeDirection()
        actionOnCurrentNode()
        move()
    }
}

func convertInfectionmap(input: String) -> Dictionary<Point2D, NodeStatus> {
    var infections = Dictionary<Point2D, NodeStatus>()
    let lines = input.split(separator: "\n").map{String($0)}
    let boxsize = lines[0].count
    let shift = (boxsize - 1) / 2
    for y in 0...lines.count-1 {
        for x in 0...boxsize-1 {
            if(lines[y][x] == "#") {
                print("Infection at point \(y):\(x), maps to \(shift-y):\(x - shift)")
                infections[Point2D(x: x - shift , y: shift-y )] = NodeStatus.infected
            }
        }
    }
    return infections
}

let input = """
..#
#..
...
"""

let input2 = """
##.###.....##..#.####....
##...#.#.#..##.#....#.#..
...#..#.###.#.###.##.####
..##..###....#.##.#..##.#
###....#####..###.#..#..#
.....#.#...#..##..#.##...
.##.#.###.#.#...##.#.##.#
......######.###......###
#.....##.#....#...#......
....#..###.#.#.####.##.#.
.#.#.##...###.######.####
####......#...#...#..#.#.
###.##.##..##....#..##.#.
..#.###.##..#...#######..
...####.#...###..#..###.#
..#.#.......#.####.#.....
..##..####.######..##.###
..#..#..##...#.####....#.
.#..#.####.#..##..#..##..
......#####...#.##.#....#
###..#...#.#...#.#..#.#.#
.#.###.#....##..######.##
##.######.....##.#.#.#..#
..#..##.##..#.#..###.##..
#.##.##..##.#.###.......#
"""


let infections = convertInfectionmap(input: input2)

let carrier = Carrier(infections)

for burst in 1...10000000 {
    carrier.tick()
}
print("Number of infections: \(carrier.numberOfInfections)")



//: [Next](@next)

