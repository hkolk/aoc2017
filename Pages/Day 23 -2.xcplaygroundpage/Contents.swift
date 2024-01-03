//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)
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

func isPrime(_ number: Int) -> Bool {
    return number > 1 && !(2..<number).contains { number % $0 == 0 }
}

var a = 0
var b = 0
var c = 0
var d = 0
var e = 0
var f = 0
var g = 0
var h = 0

a = 1
/*
b = 84
c = b
if(a != 0) {
    b = b * 100
    b = b - -1000000
    c = b
    c = c - -17000
}*/
b = 108400
c = 125400
outer: repeat {
    f = 1
    d = 2
    repeat {
        e = 2
        repeat {
            if(d * e == b) {
                f = 0
            }
            e +=  1
        } while(e - b != 0)
        d += 1
    } while (d - b != 0)
    
    if(f == 0) {
        h += 1
    }
    
    if(b - c == 0) {
        print("Done !")
        break outer
    }
    b += 17
} while(true)

print(h)

var primes = 0
var number = 108400
while(number <= 125400) {
    if(!isPrime(number)) {
        primes += 1
    }
    number += 17
}
print(primes)
