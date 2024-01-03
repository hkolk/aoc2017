extension Array {
    func chunks(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}
extension String {
    func leftPadding(toLength: Int, withPad character: Character) -> String {
        let stringLength = self.characters.count
        if stringLength < toLength {
            return String(repeatElement(character, count: toLength - stringLength)) + self
        } else {
            return String(self.suffix(toLength))
        }
    }
}
extension Int {
    func toHex() -> String {
        return String(self, radix: 16).leftPadding(toLength: 2, withPad: "0")
    }
}

extension Array where Element: Hashable {
    
    func countForElements() -> [Element: Int] {
        var counts = [Element: Int]()
        for element in self {
            counts[element] = (counts[element] ?? 0) + 1
        }
        return counts
    }
    
}

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

func countBitSet(_ num: Int) -> Int {
    let bits = MemoryLayout<Int>.size * 8
    var cnt: Int = 0
    var mask: Int = 1
    for _ in 0...bits {
        if num & mask != 0 {
            cnt += 1
        }
        mask <<= 1
    }
    return cnt
}
