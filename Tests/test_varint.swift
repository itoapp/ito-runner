import Foundation

func decodeVarint(data: [UInt8]) -> UInt64 {
    var value: UInt64 = 0
    var shift: UInt64 = 0
    var currentIndex = 0
    while true {
        let byte = data[currentIndex]
        currentIndex += 1
        value |= UInt64(byte & 0x7F) << shift
        if byte & 0x80 == 0 { break }
        shift += 7
    }
    return value
}

func decodeZigZag(_ value: UInt64) -> Int64 {
    return Int64(bitPattern: (value >> 1) ^ (~(value & 1) &+ 1))
}

let bytes: [[UInt8]] = [[1], [0], [2], [200, 1]]
for b in bytes {
    let v = decodeVarint(data: b)
    print("b:\(b) -> varint:\(v) -> zigzag:\(decodeZigZag(v))")
}
