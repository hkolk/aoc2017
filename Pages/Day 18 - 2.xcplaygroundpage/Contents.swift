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

let input3 = """
snd 1
snd 2
snd p
rcv a
rcv b
rcv c
rcv d
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
    case rcv(register:Value)
    case jgz(compare:Value, jump:Value)
    
    static func convert(_ line:String) -> Instruction {
        let components = line.split(separator: " ").map{ String($0) }
        switch components[0] {
        case "snd": return .snd(frequency:Value(components[1]))
        case "set": return .set(register:Value(components[1]), value:Value(components[2]))
        case "add": return .add(register:Value(components[1]), value:Value(components[2]))
        case "mul": return .mul(register:Value(components[1]), value:Value(components[2]))
        case "mod": return .mod(register:Value(components[1]), value:Value(components[2]))
        case "rcv": return .rcv(register:Value(components[1]))
        case "jgz": return .jgz(compare:Value(components[1]), jump:Value(components[2]))
        default: fatalError("Invalid type: \(components[0])")
        }
    }
}

class Program {
    var registers = Dictionary<String, Int>()
    var position: Int = 0
    let instructions: Array<Instruction>
    var messages = Array<Int>()
    var otherProgram:Program?
    var locked = false
    var sendCounter = 0
    var pid: Int
    
    init(instructions: Array<Instruction>, programId:Int) {
        self.instructions = instructions
        self.registers["p"] = programId
        self.pid = programId
    }
    
    func tick() {
        //print("[pid: \(pid), pos: \(position)] \(instructions[position])")
        switch instructions[position] {
        case .snd(let frequency):
            if let value = frequency.getIntValue() ?? registers[frequency.getRegister()!] {
                otherProgram!.messages.append(value)
                sendCounter += 1
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
        case .rcv(let register):
            if(messages.isEmpty) {
                locked = true
                position -= 1
            } else {
                locked = false
                registers[register.getRegister()!] = messages.removeFirst()
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
    
    func validPos() -> Bool {
        return (position >= 0 && position < instructions.count)
    }
}

let instructions = input2.split(separator: "\n").map { Instruction.convert(String($0)) }

let program1 = Program(instructions: instructions, programId: 0)
let program2 = Program(instructions: instructions, programId: 1)
program1.otherProgram = program2
program2.otherProgram = program1


while(!(program1.locked && program2.locked) && program1.validPos() && program2.validPos()) {
    program1.tick()
    program2.tick()
}
print("Send counter for program 1: \(program1.sendCounter)")



