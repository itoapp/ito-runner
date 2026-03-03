import Foundation

struct AnyCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    init?(stringValue: String) { self.stringValue = stringValue; self.intValue = nil }
    init?(intValue: Int) { self.stringValue = ""; self.intValue = intValue }
}

class _PostcardDecoder: Decoder {
    var codingPath: [CodingKey] = []
    var userInfo: [CodingUserInfoKey : Any] = [:]
    
    let data: [UInt8]
    var currentIndex: Int = 0
    
    init(data: [UInt8]) {
        self.data = data
    }
    
    var isAtEnd: Bool {
        return currentIndex >= data.count
    }
    
    func decodeVarint() throws -> UInt64 {
        var value: UInt64 = 0
        var shift: UInt64 = 0
        
        while true {
            let byte = data[currentIndex]
            currentIndex += 1
            value |= UInt64(byte & 0x7F) << shift
            if byte & 0x80 == 0 {
                break
            }
            shift += 7
        }
        return value
    }
    
    func decodeZigZag(_ value: UInt64) -> Int64 {
        return Int64(bitPattern: (value >> 1) ^ (~(value & 1) &+ 1))
    }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey { fatalError() }
    func singleValueContainer() throws -> SingleValueDecodingContainer { fatalError() }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        let lengthInt = try decodeVarint()
        let count = Int(lengthInt)
        print("Creating unkeyed container with \(count) elements")
        return _PostcardUnkeyedDecodingContainer(decoder: self, count: count)
    }
}

struct _PostcardUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    var codingPath: [CodingKey] { decoder.codingPath }
    let decoder: _PostcardDecoder
    var count: Int?
    var currentIndex: Int = 0
    var isAtEnd: Bool { currentIndex >= (count ?? 0) }
    
    var hasReturnedCount = false
    
    mutating func decodeNil() throws -> Bool { return false }
    
    mutating func decode(_ type: Int.Type) throws -> Int {
        if !hasReturnedCount {
            print("Array asked for count! Returning: \(count!)")
            hasReturnedCount = true
            return count!
        }
        fatalError("Oh no, array actually wanted an INT element")
    }
    
    mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        print("Unkeyed decoding element \(currentIndex) of type \(type)")
        if type == Int32.self {
            let zigZag = try decoder.decodeVarint()
            let value = decoder.decodeZigZag(zigZag)
            currentIndex += 1
            return Int32(value) as! T
        }
        fatalError()
    }
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey { fatalError() }
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer { fatalError() }
    mutating func superDecoder() throws -> Decoder { fatalError() }
}

let data: [UInt8] = [4, 1, 0, 2, 200, 1]
let d = _PostcardDecoder(data: data)
let result = try [Int32](from: d)
print("done: \(result)")
