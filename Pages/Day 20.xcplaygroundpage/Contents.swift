//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

extension Array {
    func grouped<T>(by criteria: (Element) -> T) -> [T: [Element]] {
        var groups = [T: [Element]]()
        for element in self {
            let key = criteria(element)
            if groups.keys.contains(key) == false {
                groups[key] = [Element]()
            }
            groups[key]?.append(element)
        }
        return groups
    }
}

let input = """
p=<-6,0,0>, v=< 3,0,0>, a=< 0,0,0>
p=<-4,0,0>, v=< 2,0,0>, a=< 0,0,0>
p=<-2,0,0>, v=< 1,0,0>, a=< 0,0,0>
p=< 3,0,0>, v=<-1,0,0>, a=< 0,0,0>
"""
let fileURL = Bundle.main.url(forResource: "input2", withExtension: "txt")
let input2 = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)

var particles = Array<Particle>()
let lines = input2.split(separator: "\n").map { String($0) }
for i in 0...lines.count-1 {
    particles.append(Particle.parse(lines[i], id:i))
}

for _ in 1...1000 {
    for particle in particles {
        particle.tick()
    }
    //print(tick)
    particles = particles.grouped(by: {(particle:Particle) -> xyz in
        return particle.position
    }).flatMap { (key, value) -> Particle? in
        if(value.count == 1) {
            return value.first!
        } else {
            //print("Found colission: \(value)")
            return nil
        }
    }
}
//print(particles)

let closestToZero = particles.min{ a, b in
    a.position.distanceFromZero() < b.position.distanceFromZero()
}
print(closestToZero!)
print("Left: \(particles.count)")

