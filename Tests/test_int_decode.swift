import Foundation
func decodeZigZag(_ value: UInt64) -> Int64 {
    return Int64((value >> 1) ^ (~(value & 1) &+ 1))
}
let zz = decodeZigZag(1)
print(zz)
print(Int(zz))
// Int32 cast
print(Int32(zz))
