//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
let input = """
0/2
2/2
2/3
3/4
3/5
0/1
10/1
9/10
"""

let input2 = """
24/14
30/24
29/44
47/37
6/14
20/37
14/45
5/5
26/44
2/31
19/40
47/11
0/45
36/31
3/32
30/35
32/41
39/30
46/50
33/33
0/39
44/30
49/4
41/50
50/36
5/31
49/41
20/24
38/23
4/30
40/44
44/5
0/43
38/20
20/16
34/38
5/37
40/24
22/17
17/3
9/11
41/35
42/7
22/48
47/45
6/28
23/40
15/15
29/12
45/11
21/31
27/8
18/44
2/17
46/17
29/29
45/50
"""

struct Component : Equatable {
    
    let name : (Int, Int)
    var aSide : Int
    var bSide : Int
    
    init(_ name: (Int, Int)) {
        self.name = name
        self.aSide = name.0
        self.bSide = name.1
    }
    func strength() -> Int {
        return aSide + bSide
    }
    
    func canConnect(to: Int) -> Bool {
        return to == aSide || to == bSide
    }
    
    func connect(to: Int) -> Component {
        var newComponent = Component(self.name)
        if(self.name.0 == to) {
            newComponent.aSide = self.name.0
            newComponent.bSide = self.name.1
        } else {
            newComponent.aSide = self.name.1
            newComponent.bSide = self.name.0
        }
        //print("Connecting \(self) to \(to)")
        return newComponent
    }
    
    func findWinners(remainingComponents: [Component]) -> [[Component]] {
        let componentsWithoutSelf = remainingComponents.filter { $0 != self }
        let leafs = componentsWithoutSelf.reduce(into: [Component](), { accu, component in
            if(component.canConnect(to: bSide)) {
                accu.append(component)
            }
        })
        if(leafs.count == 0) {
            return [[self]]
        } else {
            let winners = leafs.reduce(into: [[Component]](), { accu, leaf in
                let curLength = accu.first?.count ?? 0
                let subWinners = leaf.connect(to: self.bSide).findWinners(remainingComponents: componentsWithoutSelf)
                let subLength = subWinners.first?.count ?? 0
                if(subLength > curLength) {
                    accu.removeAll()
                    accu.append(contentsOf: subWinners)
                } else if(subLength == curLength) {
                    accu.append(contentsOf: subWinners)
                }
            })
            return winners.map {
                var retval = [self]
                retval.append(contentsOf: $0)
                return retval
            }
        }
    }
    
    static func ==(lhs: Component, rhs: Component) -> Bool {
        return lhs.name == rhs.name
    
    }
    
}

let lines = input2.split(separator: "\n").map{String($0)}


var components = [Component]()
for line in lines {
    let parts = line.split(separator: "/").map{Int(String($0))!}
    components.append(Component((parts[0], parts[1])))
}
/*
components.append(Component((0, 2)))
components.append(Component((2, 2)))
components.append(Component((2, 3)))
components.append(Component((3, 4)))
components.append(Component((3, 5)))
components.append(Component((0, 1)))
components.append(Component((10, 1)))
components.append(Component((9, 10)))
*/
let root = Component((0, 0))
components.append(root)
let winners = root.findWinners(remainingComponents: components)
var maxStrength = 0
for winner in winners {
    var length = 0
    var strength = 0
    for component in winner {
        strength += component.strength()
        length += 1
        print("\(component.aSide)/\(component.bSide) ", terminator:"")
    }
    print("")
    print("Strength: \(strength), Length: \(length)")
    if(strength > maxStrength) {
        maxStrength = strength
    }
}
print("Maxstrength: \(maxStrength)")



