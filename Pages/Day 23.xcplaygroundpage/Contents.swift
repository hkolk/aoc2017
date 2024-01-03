//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


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
    case set(register:Value, value:Value)
    case sub(register:Value, value:Value)
    case mul(register:Value, value:Value)
    case jnz(compare:Value, jump:Value)
    
    static func convert(_ line:String) -> Instruction {
        let components = line.split(separator: " ").map{ String($0) }
        switch components[0] {
        case "set": return .set(register:Value(components[1]), value:Value(components[2]))
        case "sub": return .sub(register:Value(components[1]), value:Value(components[2]))
        case "mul": return .mul(register:Value(components[1]), value:Value(components[2]))
        case "jnz": return .jnz(compare:Value(components[1]), jump:Value(components[2]))
        default: fatalError("Invalid type: \(components[0])")
        }
    }
}

class Program {
    var registers = Dictionary<String, Int>()
    var position: Int = 0
    let instructions: Array<Instruction>
    var mulCounter = 0
    
    init(instructions: Array<Instruction>) {
        registers["a"] = 1
        self.instructions = instructions
    }
    
    func tick() {
        //print("[pid: \(pid), pos: \(position)] \(instructions[position])")
        switch instructions[position] {

        case .set(let register, let value):
            if let actualValue = value.getIntValue() ?? registers[value.getRegister()!] {
                registers[register.getRegister()!] = actualValue
            }
        case .sub(let register, let value):
            if let actualValue = value.getIntValue() ?? registers[value.getRegister()!] {
                registers[register.getRegister()!] = (registers[register.getRegister()!] ?? 0) - actualValue
            }
        case .mul(let register, let value):
            if let actualValue = value.getIntValue() ?? registers[value.getRegister()!] {
                registers[register.getRegister()!] = (registers[register.getRegister()!] ?? 0) * actualValue
            }
            mulCounter += 1
        case .jnz(let compare, let jump):
            if let actualValue = compare.getIntValue() ?? registers[compare.getRegister()!] {
                if(actualValue != 0) {
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

let input = """
set b 84
set c b
jnz a 2
jnz 1 5
mul b 100
sub b -100000
set c b
sub c -17000
set f 1
set d 2
set e 2
set g d
mul g e
sub g b
jnz g 2
set f 0
sub e -1
set g e
sub g b
jnz g -8
sub d -1
set g d
sub g b
jnz g -13
jnz f 2
sub h -1
set g b
sub g c
jnz g 2
jnz 1 3
sub b -17
jnz 1 -23
"""

let instructions = input.split(separator: "\n").map { Instruction.convert(String($0)) }

let program1 = Program(instructions: instructions)

var breaker = 0
while(program1.validPos() && breaker < 1000) {
    program1.tick()
    breaker += 1
}
print("Mulitply counter for program 1: \(program1.mulCounter)")




