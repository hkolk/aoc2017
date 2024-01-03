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

enum Direction {
    case north, west, south, east
    
    func nextDirection(isInfected: Bool) -> Direction {
        switch self {
        case .north: return (isInfected) ? .east : .west
        case .south: return (isInfected) ? .west : .east
        case .west:  return (isInfected) ? .north : .south
        case .east:  return (isInfected) ? .south : .north
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
    var infections = Dictionary<Point2D, Bool>()
    var currentDirection = Direction.north
    var currentLocation = Point2D(x: 0, y: 0)
    var numberOfInfections = 0

    init(_ infections: Dictionary<Point2D, Bool>) {
        self.infections = infections
    }
    
    func changeDirection() {
        let isInfected = infections.keys.contains(currentLocation)
        currentDirection = currentDirection.nextDirection(isInfected: isInfected)
    }
    
    func infectOrClean() {
        let isInfected = infections.keys.contains(currentLocation)
        if(isInfected) {
            infections.removeValue(forKey: currentLocation)
        } else {
            numberOfInfections += 1
            infections[currentLocation] = true
        }
    }
    
    func move() {
        currentLocation = currentLocation.move(direction: currentDirection)
    }
    
    func tick() {
        changeDirection()
        infectOrClean()
        move()
    }
}

func convertInfectionmap(input: String) -> Dictionary<Point2D, Bool> {
    var infections = Dictionary<Point2D, Bool>()
    let lines = input.split(separator: "\n").map{String($0)}
    let boxsize = lines[0].count
    let shift = (boxsize - 1) / 2
    for y in 0...lines.count-1 {
        for x in 0...boxsize-1 {
            if(lines[y][x] == "#") {
                print("Infection at point \(y):\(x), maps to \(shift-y):\(x - shift)")
                infections[Point2D(x: x - shift , y: shift-y )] = true
            }
        }
    }
    return infections
}

let input = """
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


let infections = convertInfectionmap(input: input)

let carrier = Carrier(infections)

for burst in 1...70 {
    carrier.tick()
}
print("Number of infections: \(carrier.numberOfInfections)")



//: [Next](@next)
