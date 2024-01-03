//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

extension Int {
    func square() -> Int {
        return self * self
    }
}

func layerSize(_ forLayer: Int) -> Int {
    return forLayer * 8
}

func calculateHighestLayerNumber(_ forLayer: Int) -> Int {
    return (forLayer * 2 + 1).square()
}

func calculateLayer(_ forNumber:Int) -> Int {
    var layer = 0
    while(forNumber > calculateHighestLayerNumber(layer) ) {
        layer += 1
    }
    return layer
}

func getDistance(_ forNumber:Int) -> Int {
    if(forNumber < 2) {
        return 0
    }
    let layer = calculateLayer(forNumber)
    let highestLayerNumber = calculateHighestLayerNumber(layer)
    let difference = highestLayerNumber - forNumber
    let distance = (difference + layer) % (layer * 2)
    let bla = layer - abs(layer - distance)
    return layer + bla
}

calculateLayer(1)
calculateLayer(5)
calculateLayer(9)
calculateLayer(10)
calculateLayer(25)
calculateLayer(48)
calculateLayer(100)

getDistance(25)
getDistance(23)
getDistance(24)
getDistance(21)
getDistance(19)
getDistance(17)
getDistance(15)
getDistance(14)
getDistance(13)
getDistance(12)
getDistance(11)
getDistance(49)
getDistance(27)

getDistance(1) == 0
getDistance(12) == 3
getDistance(23) == 2
getDistance(1026)
getDistance(1025)
getDistance(1024) == 31
getDistance(289326)

//: [Next](@next)
