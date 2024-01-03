//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

let input = """
0: 3
1: 2
4: 4
6: 4
"""

let input2="""
0: 3
1: 2
2: 5
4: 4
6: 6
8: 4
10: 8
12: 8
14: 6
16: 8
18: 6
20: 6
22: 8
24: 12
26: 12
28: 8
30: 12
32: 12
34: 8
36: 10
38: 9
40: 12
42: 10
44: 12
46: 14
48: 14
50: 12
52: 14
56: 12
58: 12
60: 14
62: 14
64: 12
66: 14
68: 14
70: 14
74: 24
76: 14
80: 18
82: 14
84: 14
90: 14
94: 17
"""

let scanners:Dictionary<Int, Int> = input2.split(separator: "\n").map { $0.components(separatedBy: ": ") }
    .reduce(into: [Int:Int]()) { dict, pair in
        if pair.count == 2, let key = Int(pair[0]), let value = Int(pair[1]) {
            dict[key] = value
        }
}
print(scanners)

var highestDepth = scanners.keys.max()!
for delay in 0...100000 {
    var impact = 0
    var hit = false
    inner: for depth in 0...highestDepth {
        let second = depth + delay
        if let scannerWidth = scanners[depth] {
            let actualRange = (scannerWidth-1) * 2
            let currentScannerLocation = second % actualRange
            //print("\(second), \(depth), \(actualRange), \(currentScannerLocation)")
            if currentScannerLocation == 0 {
                impact += depth + scannerWidth
                hit = true
                break inner
            }
        }
    }
    if(!hit) {
        print("Delay: \(delay), Impact: \(impact)")
        break
    }
}
//: [Next](@next)
