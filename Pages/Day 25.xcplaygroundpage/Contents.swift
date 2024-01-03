//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

enum States {
    case A, B, C, D, E, F
}

class Tape {
    var setbits = Dictionary<Int, Bool>()
    var curPos = 0
    
    func getValue() -> Bool {
        return setbits[curPos] ?? false
    }
    
    func setValue(_ value: Bool) {
        if(value) {
            setbits[curPos] = true
        } else {
            setbits.removeValue(forKey: curPos)
        }
    }
    func moveRight() {
        curPos += 1
    }
    func moveLeft() {
        curPos -= 1
    }
    
    func printTape() {
        let min = (setbits.keys.min() ?? 0) - 2
        let max = (setbits.keys.max() ?? 0) + 2
        for i in min...max {
            var value = (setbits[i] ?? false) ? "1" : "0"
            if(i == curPos) {
                value = "[\(value)]"
            }
            print("\(value) ", terminator:"")
        }
        print("")
    }
    
    func checkSum() -> Int {
        return setbits.count
    }
}

var state = States.A
let tape = Tape()
/*
for _ in 1...6 {
    switch state {
    case .A:
        if(!tape.getValue()) {
            tape.setValue(true)
            tape.moveRight()
            state = .B
        } else {
            tape.setValue(false)
            tape.moveLeft()
            state = .B
        }
    case .B:
        if(!tape.getValue()) {
            tape.setValue(true)
            tape.moveLeft()
            state = .A
        } else {
            tape.setValue(true)
            tape.moveRight()
            state = .B
        }
    }
}
 */
for _ in 1...100 {
    switch state {
    case .A:
        if(!tape.getValue()) {
            tape.setValue(true)
            tape.moveRight()
            state = .B
        } else {
            tape.setValue(false)
            tape.moveLeft()
            state = .B
        }
    case .B:
        if(!tape.getValue()) {
            tape.setValue(false)
            tape.moveRight()
            state = .C
        } else {
            tape.setValue(true)
            tape.moveLeft()
            state = .B
        }
    case .C:
        if(!tape.getValue()) {
            tape.setValue(true)
            tape.moveRight()
            state = .D
        } else {
            tape.setValue(false)
            tape.moveLeft()
            state = .A
        }
    case .D:
        if(!tape.getValue()) {
            tape.setValue(true)
            tape.moveLeft()
            state = .E
        } else {
            tape.setValue(true)
            tape.moveLeft()
            state = .F
        }
    case .E:
        if(!tape.getValue()) {
            tape.setValue(true)
            tape.moveLeft()
            state = .A
        } else {
            tape.setValue(false)
            tape.moveLeft()
            state = .D
        }
    case .F:
        if(!tape.getValue()) {
            tape.setValue(true)
            tape.moveRight()
            state = .A
        } else {
            tape.setValue(true)
            tape.moveLeft()
            state = .E
        }
    }
}
tape.printTape()
print(tape.checkSum())
