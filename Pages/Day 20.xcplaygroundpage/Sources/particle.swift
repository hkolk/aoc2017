import Foundation

//: [Next](@next)
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

public struct xyz : Hashable {
    let x: Int
    let y: Int
    let z: Int
    
    func apply(_ apply: xyz) -> xyz {
        return xyz(x: self.x + apply.x, y: self.y + apply.y, z: self.z + apply.z)
    }
    
    public var hashValue: Int {
        return x.hashValue ^ y.hashValue ^ z.hashValue &* 16777619
    }
    
    public static func == (lhs: xyz, rhs: xyz) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
    
    public func distanceFromZero() -> Int {
        return abs(x) + abs(y) + abs(z)
    }
    
    static func parse(_ vec: String) -> xyz {
        let parts = vec.components(separatedBy: CharacterSet(charactersIn:"<>, ")).flatMap {$0.isEmpty ? nil : String($0)}
        //print(parts)
        return xyz(x: Int(parts[0])!, y:Int(parts[1])!, z:Int(parts[2])!)
    }
}

public class Particle: CustomStringConvertible {
    public var position: xyz
    var velocity: xyz
    var acceleration: xyz
    var id: Int
    
    init(position:xyz, velocity:xyz, acceleration:xyz, id:Int) {
        self.position = position
        self.velocity = velocity
        self.acceleration = acceleration
        self.id = id
    }
    
    public var description : String {
        get {
            return "Particle \(id): \(self.position), \(self.velocity), \(self.acceleration)"
        }
    }
    
    public func tick() {
        velocity = velocity.apply(acceleration)
        position = position.apply(velocity)
    }
    
    public static func parse(_ line: String, id:Int) -> Particle {
        // p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>
        var position: xyz? = nil
        var velocity: xyz? = nil
        var acceleration: xyz? = nil
        let parts = line.components(separatedBy: ">, ").map { String($0)}
        //print(parts)
        for part in parts {
            switch part[0] {
            case "p": position = xyz.parse(part[2..<part.count])
            case "v": velocity = xyz.parse(part[2..<part.count])
            case "a": acceleration = xyz.parse(part[2..<part.length])
            default: fatalError("Unknown type \(part[0])")
            }
        }
        return Particle(position: position!, velocity: velocity!, acceleration: acceleration!, id: id)
    }
}
