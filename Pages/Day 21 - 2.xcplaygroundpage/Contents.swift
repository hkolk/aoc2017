//: [Previous](@previous)

import Foundation



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

class StringMatrix: CustomStringConvertible {
    let rows: Int, columns: Int
    var grid: [String]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: " ", count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> String {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
    func getSquare(row: Int, column: Int, size:Int) -> String {
        var accu = ""
        for i in 0...(size * size) - 1 {
            let y = row + (i / size)
            let x = column + (i % size)
            accu.append(self[y, x])
        }
        return accu
    }
    
    func setSquare(row: Int, column: Int, square: String) {
        let size = Int(sqrt(Double(square.count)))
        for i in 0...(size * size) - 1 {
            let y = row + (i / size)
            let x = column + (i % size)
            self[y, x] = square[i]
        }
    }
    
    var description: String {
        get {
            var accu = "Matrix of rows: \(rows) and columns: \(columns): \n"
            for x in 0...rows-1 {
                for y in 0...columns-1 {
                    accu.append(self[x, y])
                }
                accu.append("\n")
            }
            return accu
        }
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


func splitIntoFour(_ input:String) -> [String] {
    return [
        "\(input[0])\(input[1])\(input[4])\(input[5])",
        "\(input[2])\(input[3])\(input[6])\(input[7])",
        "\(input[8])\(input[9])\(input[12])\(input[13])",
        "\(input[10])\(input[11])\(input[14])\(input[15])"
    ]
}


func doOnCount(_ grid:StringMatrix) -> Int {
    return grid.getSquare(row: 0, column: 0, size: grid.rows).replacingOccurrences(of: ".", with: "").count
}

var gridString = ".#...####"

var gridSize = 3
var grid = StringMatrix(rows: gridSize, columns: gridSize)
grid.setSquare(row: 0, column: 0, square: gridString)
print(grid)


for iteration in 1...18 {
    if(grid.rows % 2 == 0) {
        gridSize = (grid.rows / 2) * 3
        let newGrid = StringMatrix(rows: gridSize, columns: gridSize)
        for x in 0...(grid.rows / 2) - 1 {
            for y in 0...(grid.columns / 2) - 1 {
                let square = grid.getSquare(row: x*2, column: y*2, size: 2)
                if let result = patternLibrary[square] {
                    //print("Setting x \(x * 3) and y \(y * 3) to \(result)")
                    newGrid.setSquare(row: x * 3, column: y * 3, square: result)
                } else {
                    print("Pattern for \(square) not found?!")
                }
            }
        }
        grid = newGrid
    } else {
        gridSize = (grid.rows / 3) * 4
        let newGrid = StringMatrix(rows: gridSize, columns: gridSize)
        for x in 0...(grid.rows / 3) - 1 {
            for y in 0...(grid.columns / 3) - 1 {
                let square = grid.getSquare(row: x*3, column: y*3, size: 3)
                if let result = patternLibrary[square] {
                    newGrid.setSquare(row: x * 4, column: y * 4, square: result)
                } else {
                    print("Pattern for \(square) not found?!")
                }
            }
        }
        grid = newGrid
    }

    //printGrid(newGrid)
    //print(grid)
    let onCount = doOnCount(grid)
    print("Iteration \(iteration), OnCount: \(onCount)")
    //print(grid)
}



//: [Next](@next)

//: [Next](@next)
