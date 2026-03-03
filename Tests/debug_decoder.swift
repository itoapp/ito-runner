import Foundation

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
    
    func consume(_ count: Int) throws -> ArraySlice<UInt8> {
        let endIndex = currentIndex + count
        guard endIndex <= data.count else {
            throw NSError(domain: "ItoError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unexpected end of data."])
        }
        let slice = data[currentIndex..<endIndex]
        currentIndex = endIndex
        return slice
    }
    
    func decodeVarint() throws -> UInt64 {
        var value: UInt64 = 0
        var shift: UInt64 = 0
        
        while true {
            guard currentIndex < data.count else {
                throw NSError(domain: "ItoError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Corrupted varint."])
            }
            let byte = data[currentIndex]
            currentIndex += 1
            
            value |= UInt64(byte & 0x7F) << shift
            if byte & 0x80 == 0 {
                break
            }
            shift += 7
            if shift >= 64 {
                throw NSError(domain: "ItoError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Varint too large."])
            }
        }
        return value
    }
    
    func decodeZigZag(_ value: UInt64) -> Int64 {
        return Int64((value >> 1) ^ (~(value & 1) &+ 1))
    }
    
    func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        fatalError()
    }
    
    func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        let lengthInt = try decodeVarint()
        let count = Int(lengthInt)
        print("DECODING ARRAY of length \(count)")
        return _PostcardUnkeyedDecodingContainer(decoder: self, count: count)
    }
    
    func singleValueContainer() throws -> SingleValueDecodingContainer {
        return _PostcardSingleValueDecoder(decoder: self)
    }
}

struct _PostcardUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    var codingPath: [CodingKey] { decoder.codingPath }
    let decoder: _PostcardDecoder
    var count: Int?
    var isAtEnd: Bool { currentIndex >= (count ?? 0) }
    var currentIndex: Int = 0
    
    mutating func decodeNil() throws -> Bool { print("DECODE ARRAY NIL"); return false }
    mutating func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        print("DECODE ARRAY ELEMENT \(currentIndex) of type \(T.self)")
        currentIndex += 1
        return try T(from: decoder)
    }
    mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey : CodingKey { fatalError() }
    mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer { fatalError() }
    mutating func superDecoder() throws -> Decoder { fatalError() }
}

struct _PostcardSingleValueDecoder: SingleValueDecodingContainer {
    var codingPath: [CodingKey] { decoder.codingPath }
    let decoder: _PostcardDecoder
    func decodeNil() -> Bool { fatalError() }
    func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        if type == Int32.self {
            let zigZag = try decoder.decodeVarint()
            let value = decoder.decodeZigZag(zigZag)
            return Int32(value) as! T
        }
        fatalError()
    }
}

let decoder = _PostcardDecoder(data: [4, 1, 0, 2, 200, 1, 0])
let arr = try [Int32](from: decoder)
print("DECODED ARR: \(arr)")
print("REMAINING DATA: \(decoder.data[decoder.currentIndex...])")

