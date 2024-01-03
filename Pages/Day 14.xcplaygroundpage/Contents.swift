//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

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

//let size = 5
//let lengths = [3, 4, 1, 5]
//let lengths = [227,169,3,166,246,201,0,47,1,255,2,254,96,3,97,144]
func knotHash(_ input:String) -> String {
    //let input = "227,169,3,166,246,201,0,47,1,255,2,254,96,3,97,144"
    let size = 256
    let rounds = 64

    let lengths = input.map{ Int($0.unicodeScalars.first!.value) } + [17, 31, 73, 47, 23]

    //print(lengths)

    var list = Array(0...size-1)

    var curPos = 0
    var skip = 0

    for _ in 1...rounds {
        for length in lengths {
            if(length > 1 && length <= size) {
                for i in 0...(length / 2 - 1) {
                    let swap1 = (curPos + i) % size
                    let swap2 = (curPos + length - i - 1) % size
                    //print(swap1, swap2)
                    list.swapAt(swap1, swap2)
                }
            }
            curPos += (length + skip) % size
            skip += 1
            //print(list)
        }
    }
    let denseHash = list.chunks(16).map{$0.reduce(0, { result, item in
        return result ^ item
    } )}.map { $0.toHex()  }.joined()
    return denseHash
}



let input = "flqrgnkx"
var hashes = Array<String>()
/*
for rowId in 0...127 {
    let hash = knotHash("\(input)-\(rowId)")
    print(hash)
    hashes.append(hash)
}*/
let intermediate = """
d0a46669c89a010999d028896ea2b9bc
f23f57f753c30072230007d24007556b
5950f8bbeaad241d617aaaa0b06534c4
1fb4ba1f311caed368fa4096535b4a58
5837b45a0f8b63a452d0a5aa60d223de
6a60f3082a36d32feee3d083837ba710
aef744de2183474cdff03069055b98da
0ea0fcf3e5bbf062f1b5ddae664f7b08
f0769ffe23cdbeef1c4c56ede71e0b41
e6fa552d514933b7290257fb3a56a4b7
1b955904bc61be00fa509924277358ab
7cda254163c56f12fd66e3b557ed7719
134d9780a7392c16db7c82bde2541bd8
8981647a37b8e9b4557fd6cf84d8b11a
6d476e513345c45943ae1d529ce5a683
cda10c114dc8b12b08b9fdaf5187a9f2
a9a7245486109ec8ce544639e907f247
c51f86b5d5c1a90d61d278beca35bc6f
b3beb72fa1881bd08ecd3ce1cc521b6c
b6af7861eb86fccec3b71a158b13c579
ca5745abeda71265388e8c756db1fa27
34cb09cf31ef6cfdcaf57b17ca9beb9f
0ae1c22638d1b2c8e910202bbb659525
1b813ab22d7649b84abf5c9cc5286707
24520bdbe536ca8fac628a00c7d5e385
c5d3413c65a733ba871874d5f8f1392e
f187329aefc3fde68b0c85e9ec2c20e2
95f00705b36904d7048d1485269cce02
a3966c41e0f4156c993a6f1363ac1075
7fcfbdfd65352112a57aeec0e9965d40
a5aa7534cac477ed4fe641630a013f65
e3de487ca4f4f00102aa81c9e61903b4
927b4c327fc280680112dd634d44c3a5
711f2c054a130648e9c01e645edc50d1
e7f5f49915788b57c9379f7fafe6b22b
3f872db6057e7cc40f695d8d7551c4b6
ab4b6954b6360b3ba9d27758709a13c0
eecdc35b30cf8911a88c37624175bf26
6d542c7ec55dd5842ab3cdbb39806f9b
a26310540b4e76b844d051061931f510
08c1cbc98f279406e96e15a9807dcef9
3c87433d9d04fd9f92fbb68bb83dd43b
cf8e48c39858dd955c9b3d0b0ef21659
27d2226c758238d69b1e360a484f8a96
a4cee7d8793f7b7e7d642e34ca0bd004
5c5e299fa37c0b8fd5c980703dc8c137
9b8cedab4ba3370e0067a74b37e9f623
a4fb389a38b09f76dead0cf52aee5280
f5835782d072dbe9f41544ab6592cc06
ac71e1092ceda5878f6f5c7ad796b9e8
7221d09f42330e5e85968b4c3533c22d
9c0c8022e68009cb8302b92ab22c716b
fa18b3e67dc2cd778e4f047cfee5b4a4
43fe4bfef3d1a0fbee7f54ec7ca8a529
d10da32986d34fe3f67f1c199d6924f3
a218e2edc52513c43d83ac98b94413e6
430f6d82b2548db587e423b0de751335
5be5b92225eaa6853c3a928caf8702fb
a424e5a761c9ae31915d2138b011df5e
bd5801d4e764cb54a9460cde90df742a
c2680345392f9f8419b2b9aa94893b7f
887ac6855ade4675f8e979b693ede345
f3eabd47da4b02f1d8ff43edaee9733c
c51b7323a52f086aef803638a06422e1
a61d2b2bb176bb7b27f886bd50482c6c
9a6ee9a53fe8e982d491759707756abb
d22787fb32a9162a695c84702d57f96c
017d4039b0132ea72be75b8b8bbb282b
d007270ef2de0e2e0ed3aae4836c911f
e07dbd99ce280f9f0322cef42974840d
1462903050f63432379365f4761f371d
f55ff10f74a8001d2919a5847cdc4367
c90673476c0136561f029c5c8fa7f4f7
048abbbdcf02cd583cec530f02b26589
f6b7b45de614cb2adf8ef838c5ec9695
0db36473ad793fd33a012088d6fc6a42
9c0053335c5e7f6de2fcc9e6537b44b1
c11fc4426e9afcc7a1372312bfc6bef7
1e6c0b5887a5bf09aafd3f4818bda191
b14ce749db8513168b30a9acefabeb19
10724396074b058f429d72dd93947670
d909eccfdffc6616fe5a02afdc226a3d
9cb383d0b5b697e3a0291aa95919c9b8
9aa5c888144f96cde4683edebd4e6888
c2ab3cd6eb008d070b0f19cbdd9d80f4
cc069276f10bd9df5364b648a575a269
a97900eee26f66fd2f07a9d3f63252ec
b765a85d5bfa3443c607f7ab3feaea53
0b6ae2cdbd974540e8a7e377674ad641
cdfa840e0e90ac09128333d858890a27
7560dbeb0470150b0f1d6c78b9904525
f3100ec8c927c4ef206984f665f35d10
eceb1dedefde7ea386de5d1ee982caa1
cb27fbcf87d3ab3cc9f57482b2ad0fc1
6337004021247650e0df4f02dfacfcca
e79de54cf4171de35891432007f6d94c
7cab325698b8682f6edf6b7451c8e300
bd7036809342efb64a6b9d9fa5ae62b9
31c4c69f3712f9101ff2319a53e79e0c
8cca2b60935a93985a94f461d31e550c
1301e4de9a58e7ae3ad5b94bac43b8e9
98a209f93425b9fdd3ca9a9ccff77bc3
3022fe3291bf54aca312ead56d4668c5
067f113f38a7fea7efc1e5693bf836c6
befc4b46ad464377f31ec2b7581c2468
8a8bb1de234c1d67d39fa0087ea4a2e7
295fa27e49a2a41b04fbc029980d1d60
f9afbce35527b020d9f85720d4bb3def
788d31f89df9788a487ce911eeedcfaa
01e66d7f7d34d239e4f392b848d108fb
8e4f7aebc610bdd7d8d51034447613e4
31c8d760fd8804c441ead6526cf9bafb
fb041bb207f953042d6d2c49d4626e02
b0378630a8bee9eca7f25497867ea0ec
eb68d419f1abff28c07f365c3e32544e
3c016c7494c98ad55b6d8a394abd0451
2752b5840c345db44860ff58e4628c10
2c7930d4fbe5360ed05c519376760bd2
bebac9355b07466f6296f4466e9bd7e9
8731ad700a83bf2a4bb44d8f652c7c7f
a881c35d128e9a56f9248db39f7447a8
dd81998b1e27b3574fae6ec6b727155f
353ebaf618c1472549cfbcb8335c0a1b
c8fa3e5ae13c07a5313d8082a72f7fd0
377b844c8b286fefc526ffa08a924340
65072fdfd0237de95b841a379a9a0403
4b3f55e78be24373a760fecf04d402bb
439404966188cec3c51d6dd2da178e85
""".split(separator: "\n").map { String($0) }


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

var accu = 0
var matrix = Array(repeating:Array(repeating: false, count:128), count:128)
var rowId = 0
for row in intermediate {
    var offset = 0
    for char in row {
        let bits = Int(String(char), radix: 16)!
        var mask: Int = 1
        for i in 0...3 {
            if(bits & mask != 0) {
                //print("Offset: \(offset+(3-i))")
                matrix[rowId][offset+(3-i)] = true
            }
            mask <<= 1
        }
        accu += countBitSet(bits)
        offset += 4
    }
    //print(matrix[0])
    //break
    rowId+=1
}
print("Result: \(accu)")

func printMatrix() {
    for rowId in 0...127 {
        var accu = ""
        for columnId in 0...127 {
            accu.append(matrix[rowId][columnId] ? "1" : "0")
        }
        print(accu)
    }
}

func removeNeighbours(_ rowId:Int, _ columnId:Int) {
    if(rowId < 0 || rowId > 127 || columnId < 0 || columnId > 127) {
        return
    }
    if(matrix[rowId][columnId]) {
        matrix[rowId][columnId] = false
        removeNeighbours(rowId+1, columnId)
        removeNeighbours(rowId-1, columnId)
        removeNeighbours(rowId, columnId+1)
        removeNeighbours(rowId, columnId-1)
    }
}

var groupId = 0
for rowId in 0...127 {
    for columnId in 0...127 {
        if(matrix[rowId][columnId]) {
            removeNeighbours(rowId, columnId)
            groupId += 1
        }
    }
}
printMatrix()
print("GroupID: \(groupId)")
