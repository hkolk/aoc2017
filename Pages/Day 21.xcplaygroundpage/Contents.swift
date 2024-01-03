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



func flipAndRotate(_ input:String) -> Set<String> {
    var result = Set<String>()
    var mutation = input
    let debug = input == ""
    for _ in 0...3 {
        // rotate 4 times
        mutation = rotate(mutation)
        result.insert(mutation)
        result.insert(flip(mutation, vertical: false))
        result.insert(flip(mutation, vertical: true))
/*
        for i in 0...3 {
            // flip 4 times
            mutation = flip(mutation, vertical:(i % 2 == 0))
//            print(mutation)
            if(debug) {
                print("\(input) => \(mutation)")
            }
            result.insert(mutation)
        }
 */
    }
    return result
}

func flip(_ input:String, vertical:Bool) -> String {
    switch input.count {
    case 4: if(vertical) {
            return "\(input[2])\(input[3])\(input[0])\(input[1])"
        } else {
            return "\(input[1])\(input[0])\(input[3])\(input[2])"
        }
    case 9: if(vertical) {
            return "\(input[6])\(input[7])\(input[8])\(input[3])\(input[4])\(input[5])\(input[0])\(input[1])\(input[2])"
        } else {
            return "\(input[2])\(input[1])\(input[0])\(input[5])\(input[4])\(input[3])\(input[8])\(input[7])\(input[6])"
        }
        default: fatalError("Weird string to rotate: \(input)")
    }
}

func rotate(_ input:String) -> String {
    switch input.count {
        case 4: return "\(input[2])\(input[0])\(input[3])\(input[1])"
        case 9: return "\(input[6])\(input[3])\(input[0])\(input[7])\(input[4])\(input[1])\(input[8])\(input[5])\(input[2])"
        default: fatalError("Weird string to rotate: \(input)")
    }
}

func splitIntoFour(_ input:String) -> [String] {
    return [
        "\(input[0])\(input[1])\(input[4])\(input[5])",
        "\(input[2])\(input[3])\(input[6])\(input[7])",
        "\(input[8])\(input[9])\(input[12])\(input[13])",
        "\(input[10])\(input[11])\(input[14])\(input[15])"
    ]
}

let input = """
../.# => ##./#../...
.#./..#/### => #..#/..../..../#..#
"""

let input2 = """
../.. => .##/..#/##.
#./.. => ##./#../#..
##/.. => ###/#.#/..#
.#/#. => .../#../##.
##/#. => ###/#../###
##/## => .##/.##/#.#
.../.../... => #.##/#.##/###./..##
#../.../... => ##.#/..##/#.#./##.#
.#./.../... => ###./.#.#/.#../.###
##./.../... => ##.#/###./..../##..
#.#/.../... => ##.#/.###/.##./#.#.
###/.../... => #..#/.##./#.../.#.#
.#./#../... => .##./####/#..#/###.
##./#../... => ##../..#./#.##/..##
..#/#../... => #.##/.#.#/##../..##
#.#/#../... => #.../##../..#./.##.
.##/#../... => #.#./.#.#/#.##/#..#
###/#../... => .#../.#../...#/##..
.../.#./... => ..#./..#./##../.#.#
#../.#./... => ##../####/##../.###
.#./.#./... => ..../#..#/#.#./....
##./.#./... => ..##/####/..../##..
#.#/.#./... => #.##/##../#.../..#.
###/.#./... => ..../..../####/#..#
.#./##./... => ..../####/##.#/....
##./##./... => ####/#.../.###/#.##
..#/##./... => .#.#/.#../###./.#..
#.#/##./... => .#.#/###./..../..##
.##/##./... => #.../.#.#/.#.#/...#
###/##./... => #.##/.#../.#../#...
.../#.#/... => ###./..#./.#../..##
#../#.#/... => #..#/#.##/.#../...#
.#./#.#/... => ####/..#./..../..#.
##./#.#/... => #.#./..../.###/..#.
#.#/#.#/... => #..#/.#../#.#./.###
###/#.#/... => .##./#..#/.#.#/..#.
.../###/... => .#../#..#/...#/.##.
#../###/... => .##./##../###./##.#
.#./###/... => ...#/..##/###./...#
##./###/... => .#.#/##.#/.###/.#..
#.#/###/... => #.#./##../#.#./..#.
###/###/... => .#.#/####/###./####
..#/.../#.. => .#../#.##/..../..#.
#.#/.../#.. => ..../.#.#/##../#..#
.##/.../#.. => #.##/.#.#/#..#/.#.#
###/.../#.. => #..#/.#.#/#.#./##.#
.##/#../#.. => ##../##.#/##.#/#..#
###/#../#.. => ..../#..#/###./#.##
..#/.#./#.. => ..../.#../..../.##.
#.#/.#./#.. => #..#/#.##/.###/....
.##/.#./#.. => ###./..../##.#/#.#.
###/.#./#.. => #.../###./.#.#/..#.
.##/##./#.. => ..../.#../..#./#.#.
###/##./#.. => ...#/.###/###./####
#../..#/#.. => ..../.##./..##/..##
.#./..#/#.. => .#.#/#.../#..#/###.
##./..#/#.. => #.#./.##./.##./....
#.#/..#/#.. => #..#/..##/##.#/##..
.##/..#/#.. => ..#./#.../.##./##.#
###/..#/#.. => ##../.##./####/.##.
#../#.#/#.. => ###./#.#./###./.#.#
.#./#.#/#.. => .##./#.#./#..#/..#.
##./#.#/#.. => .#.#/#.#./#.../##.#
..#/#.#/#.. => .##./##.#/.#.#/.#.#
#.#/#.#/#.. => .#../.##./###./#...
.##/#.#/#.. => ####/##../.##./##.#
###/#.#/#.. => ###./.##./##.#/#...
#../.##/#.. => ...#/#.#./..##/####
.#./.##/#.. => #.../##.#/.##./###.
##./.##/#.. => ##.#/.#.#/..../#.#.
#.#/.##/#.. => ..../#.../.#.#/..#.
.##/.##/#.. => ##../..../..#./#.##
###/.##/#.. => ..#./...#/#..#/...#
#../###/#.. => ..../.#../#.../###.
.#./###/#.. => ..../#.#./.#.#/...#
##./###/#.. => ###./###./..#./.###
..#/###/#.. => #.##/..#./..##/#...
#.#/###/#.. => ##.#/.#.#/##../#..#
.##/###/#.. => ###./..##/#.../....
###/###/#.. => .###/###./#.../..#.
.#./#.#/.#. => ..##/##.#/.##./####
##./#.#/.#. => ..../.#.#/#.../###.
#.#/#.#/.#. => ##.#/###./..#./.#..
###/#.#/.#. => .###/##../.###/....
.#./###/.#. => ####/.###/.###/....
##./###/.#. => #.#./#..#/#..#/###.
#.#/###/.#. => #.#./.#.#/#.##/####
###/###/.#. => #.#./.###/..#./#.#.
#.#/..#/##. => ###./.#.#/##../##..
###/..#/##. => #.../.###/#.../..#.
.##/#.#/##. => #..#/.#.#/...#/.#..
###/#.#/##. => ...#/###./..##/.#.#
#.#/.##/##. => ###./...#/..../#...
###/.##/##. => ...#/#.../#.##/##..
.##/###/##. => .###/.###/..#./#...
###/###/##. => #.../##../##.#/.###
#.#/.../#.# => ##../#.##/..#./.###
###/.../#.# => #.#./.##./.##./#..#
###/#../#.# => #.../##../####/..##
#.#/.#./#.# => #.../.#../#.../..##
###/.#./#.# => #..#/###./####/#...
###/##./#.# => ##../..##/#.#./##..
#.#/#.#/#.# => .#../.#.#/#.#./.#.#
###/#.#/#.# => ..##/####/####/.###
#.#/###/#.# => .###/##../#..#/..#.
###/###/#.# => ##../#.../##.#/##..
###/#.#/### => ###./...#/####/..#.
###/###/### => .##./##../..../..#.
"""

var patternLibrary = Dictionary<String, String>()

let lines = input2.split(separator: "\n").map{ String($0) }
for pattern in lines {
    let parts = pattern.components(separatedBy: " => ")
    let rule = parts[0].replacingOccurrences(of:"/", with:"")
    let result = parts[1].replacingOccurrences(of:"/", with:"")
    let mutations = flipAndRotate(rule)
    for mutation in mutations {
        if(patternLibrary.keys.contains(mutation)) {
            fatalError("Mutation \(mutation) already exists!")
        }
        patternLibrary[mutation] = result
    }
}
//print(patternLibrary)

var grid = [".#...####"]


func printGrid(_ grid:[String]) {
    var actualGrid = [[String]]()
    let squaresPerRow = Int(sqrt(Double(grid.count)))
    for i in 0...grid.count-1 {
        let startingX = i % squaresPerRow
        let startingY = i / squaresPerRow
        let square = grid[i]
        let squareSize = Int(sqrt(Double(square.count)))
        print("Square \(i) has size \(squareSize), and should end up at x: \(startingX) and y: \(startingY)")
        for j in 0...square.count-1 {
            let xIndex = (j % squareSize) + startingX
            let yIndex = (j / squareSize) + startingY
            if(!actualGrid.indices.contains(yIndex)) {
                actualGrid.insert([String](), at: yIndex)
            }
            print(square)
            print(square[j])
            actualGrid[yIndex][xIndex] = square[j]
        }
    }
}

func doOnCount(_ grid:[String]) -> Int {
    let onCount = grid.reduce(0, { (result, square) in
        //let onInSquare = square.replacingOccurrences(of: ".", with: "").count
        //print("OnInSquare: \(onInSquare)")
        return result + square.replacingOccurrences(of: ".", with: "").count
    })
    return onCount
}

for iteration in 0...5-1 {
    var newGrid = [String]()
    for square in grid {
        if let result = patternLibrary[square] {
            print("\(square) maps to \(result)")
            if(result.count == 16) {
                newGrid.append(contentsOf: splitIntoFour(result))
            } else {
                newGrid.append(result)
            }
        } else {
            print("Pattern for \(square) not found?!")
        }
    }
    grid = newGrid
    //printGrid(newGrid)
    print(newGrid)
    let onCount = doOnCount(grid)
    print("Iteration \(iteration), OnCount: \(onCount)")
    //print(grid)
}




//: [Next](@next)
