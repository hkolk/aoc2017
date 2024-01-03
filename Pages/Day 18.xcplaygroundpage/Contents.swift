//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

let input = """
set a 1
add a 2
mul a a
mod a 5
snd a
set a 0
rcv a
jgz a -1
set a 1
jgz a -2
"""

let input2 = """
set i 31
set a 1
mul p 17
jgz p p
mul a 2
add i -1
jgz i -2
add a -1
set i 127
set p 618
mul p 8505
mod p a
mul p 129749
add p 12345
mod p a
set b p
mod b 10000
snd b
add i -1
jgz i -9
jgz a 3
rcv b
jgz b -1
set f 0
set i 126
rcv a
rcv b
set p a
mul p -1
add p b
jgz p 4
snd a
set a b
jgz 1 3
snd b
set f 1
add i -1
jgz i -11
snd a
jgz f -16
jgz a -19
"""

struct Value: CustomDebugStringConvertible {
    let value:String
    
    init(_ value:String) {
        self.value = value
    }
    
    func getRegister() -> String? {
        if(value.rangeOfCharacter(from: CharacterSet.lowercaseLetters.inverted) == nil) {
            return value
        }
        return nil
    }
    
    func getIntValue() -> Int? {
        return Int(value)
    }
    
    var debugDescription:String {
        return value
    }
}

enum Instruction {
    case snd(frequency:Value)
    case set(register:Value, value:Value)
    case add(register:Value, value:Value)
    case mul(register:Value, value:Value)
    case mod(register:Value, value:Value)
    case rcv(compare:Value)
    case jgz(compare:Value, jump:Value)
    
    static func convert(_ line:String) -> Instruction {
        let components = line.split(separator: " ").map{ String($0) }
        switch components[0] {
            case "snd": return .snd(frequency:Value(components[1]))
            case "set": return .set(register:Value(components[1]), value:Value(components[2]))
            case "add": return .add(register:Value(components[1]), value:Value(components[2]))
            case "mul": return .mul(register:Value(components[1]), value:Value(components[2]))
            case "mod": return .mod(register:Value(components[1]), value:Value(components[2]))
            case "rcv": return .rcv(compare:Value(components[1]))
            case "jgz": return .jgz(compare:Value(components[1]), jump:Value(components[2]))
            default: fatalError("Invalid type: \(components[0])")
        }
    }
}

let instructions = input2.split(separator: "\n").map { Instruction.convert(String($0)) }

var registers = Dictionary<String, Int>()

var position = 0
var lastSound = 0
var recover = lastSound

outerloop: while(position >= 0 && position < instructions.count) {
    print(instructions[position])
    switch instructions[position] {
        case .snd(let frequency):
            if let value = frequency.getIntValue() ?? registers[frequency.getRegister()!] {
                lastSound = value
            }
        case .set(let register, let value):
            if let actualValue = value.getIntValue() ?? registers[value.getRegister()!] {
                registers[register.getRegister()!] = actualValue
            }
        case .add(let register, let value):
            if let actualValue = value.getIntValue() ?? registers[value.getRegister()!] {
                registers[register.getRegister()!] = (registers[register.getRegister()!] ?? 0) + actualValue
            }
        case .mul(let register, let value):
            if let actualValue = value.getIntValue() ?? registers[value.getRegister()!] {
                registers[register.getRegister()!] = (registers[register.getRegister()!] ?? 0) * actualValue
            }
        case .mod(let register, let value):
            if let actualValue = value.getIntValue() ?? registers[value.getRegister()!] {
                registers[register.getRegister()!] = (registers[register.getRegister()!] ?? 0) % actualValue
            }
        case .rcv(let compare):
            if let actualValue = compare.getIntValue() ?? registers[compare.getRegister()!] {
                if(actualValue > 0) {
                    recover = lastSound
                    print("First recover has value of \(recover)")
                    break outerloop
                }
            }
        case .jgz(let compare, let jump):
            if let actualValue = compare.getIntValue() ?? registers[compare.getRegister()!] {
                if(actualValue > 0) {
                    if let actualJump = jump.getIntValue() ?? registers[jump.getRegister()!] {
                        position = (position - 1) + actualJump
                    }
                }
            }
    }
    position += 1
}


