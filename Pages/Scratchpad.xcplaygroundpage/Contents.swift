import Foundation

struct Location: CustomStringConvertible, Hashable, Equatable {
    // 0, 0 is center.
    // negative row is south, positive is north
    // negative column is west, positive is east
    var row: Int = 0
    var column: Int = 0
    
    mutating func update(distance: Int, heading: Heading) {
        switch heading {
        case .north:
            row += distance
        case .south:
            row -= distance
        case .east:
            column += distance
        case .west:
            column -= distance
        }
    }
    
    var description: String {
        return "Location (north: \(row) by east: \(column)) distance \(distance())"
    }
    
    func distance() -> Int {
        return abs(row) + abs(column)
    }
    
    // Hashable
    var hashValue: Int {
        return row << 16 + column
    }
    
    // Equatable
    static func == (thing1: Location, thing2: Location) -> Bool {
        return thing1.row == thing2.row && thing1.column == thing2.column
    }
}

enum Heading {
    case north, south, east, west
    
    mutating func turn(_ turn: String) {
        switch self {
        case .north:
            if turn == "L" {
                self = .west
            } else {
                self = .east
            }
        case .south:
            if turn == "L" {
                self = .east
            } else {
                self = .west
            }
        case .east:
            if turn == "L" {
                self = .north
            } else {
                self = .south
            }
        case .west:
            if turn == "L" {
                self = .south
            } else {
                self = .north
            }
        }
    }
}


var location = Location()
location
var heading: Heading = .north

// let sequence = ["R2", "L3"]
// let sequence = ["R2", "R2", "R2"]
// let sequence = ["R5", "L5", "R5", "R3"]
let sequence = ["R2", "L5", "L4", "L5", "R4", "R1", "L4", "R5", "R3", "R1", "L1",
                "L1", "R4", "L4", "L1", "R4", "L4", "R4", "L3", "R5", "R4", "R1",
                "R3", "L1", "L1", "R1", "L2", "R5", "L4", "L3", "R1", "L2", "L2",
                "R192", "L3", "R5", "R48", "R5", "L2", "R76", "R4", "R2", "R1", "L1",
                "L5", "L1", "R185", "L5", "L1", "R5", "L4", "R1", "R3", "L4", "L3",
                "R1", "L5", "R4", "L4", "R4", "R5", "L3", "L1", "L2", "L4", "L3",
                "L4", "R2", "R2", "L3", "L5", "R2", "R5", "L1", "R1", "L3", "L5",
                "L3", "R4", "L4", "R3", "L1", "R5", "L3", "R2", "R4", "R2", "L1",
                "R3", "L1", "L3", "L5", "R4", "R5", "R2", "R2", "L5", "L3", "L1",
                "L1", "L5", "L2", "L3", "R3", "R3", "L3", "L4", "L5", "R2", "L1",
                "R1", "R3", "R4", "L2", "R1", "L1", "R3", "R3", "L4", "L2", "R5",
                "R5", "L1", "R4", "L5", "L5", "R1", "L5", "R4", "R2", "L1", "L4",
                "R1", "L1", "L1", "L5", "R3", "R4", "L2", "R1", "R2", "R1", "R1",
                "R3", "L5", "R1", "R4"]
let input = "R3, L5, R1, R2, L5, R2, R3, L2, L5, R5, L4, L3, R5, L1, R3, R4, R1, L3, R3, L2, L5, L2, R4, R5, R5, L4, L3, L3, R4, R4, R5, L5, L3, R2, R2, L3, L4, L5, R1, R3, L3, R2, L3, R5, L194, L2, L5, R2, R1, R1, L1, L5, L4, R4, R2, R2, L4, L1, R2, R53, R3, L5, R72, R2, L5, R3, L4, R187, L4, L5, L2, R1, R3, R5, L4, L4, R2, R5, L5, L4, L3, R5, L2, R1, R1, R4, L1, R2, L3, R5, L4, R2, L3, R1, L4, R4, L1, L2, R3, L1, L1, R4, R3, L4, R2, R5, L2, L3, L3, L1, R3, R5, R2, R3, R1, R2, L1, L4, L5, L2, R4, R5, L2, R4, R4, L3, R2, R1, L4, R3, L3, L4, L3, L1, R3, L2, R2, L4, L4, L5, R3, R5, R3, L2, R5, L2, L1, L5, L1, R2, R4, L5, R2, L4, L5, L4, L5, L2, L5, L4, R5, R3, R2, R2, L3, R3, L2, L5"
//let input = "R2, L3"
let moves = input.replacingOccurrences(of: " ", with: "").split(separator: ",")
// let sequence = ["R8", "R4", "R4", "R8"]

var visitedSites = Set<Location>()

for var move in moves {
    let turn = String(move.characters.prefix(1))  // "R" or "L" - assumes input is well-formed
    move.remove(at: move.startIndex) // lop off the turn
    guard let distance = Int(move) else { continue }
    
    heading.turn(turn)
    
    for i in 0 ..< distance {
        location.update(distance: 1, heading: heading)
        
        if visitedSites.contains(location) {
            print("AH HA! - \(location)")
        }
        visitedSites.insert(location)
    }
}

heading
location
