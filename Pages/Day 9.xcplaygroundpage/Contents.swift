//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
let input = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
var garbage = false
var ignoreNext = false
var depth = 0
var score = 0
var garbageCounter = 0

for char in input {
    if(ignoreNext) {
        ignoreNext = false
        continue
    }
    if(char == "!") {
        ignoreNext = true
        continue
    }
    if(garbage) {
        if(char == ">") {
            garbage = false
        } else {
            garbageCounter += 1
        }
        continue
    }
    if(char == "<") {
        garbage = true
        continue
    }
    if(char == "{") {
        depth += 1
    }
    if(char == "}") {
        score += depth
        depth -= 1
    }
}
print("score: \(score)")
print("garbageCounter: \(garbageCounter)")

//: [Next](@next)
